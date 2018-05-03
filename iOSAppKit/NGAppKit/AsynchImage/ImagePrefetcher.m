//
//  AsynchImagePrefetcher.m
//  NGAppKit
//
//  Created by Towhid Islam on 11/16/17.
//  Copyright © 2017 Towhid Islam. All rights reserved.
//

#import "ImagePrefetcher.h"
#import "QueueManager.h"

@interface ImgOperation: AsynchOperation
@property (nonatomic, strong) AsynchImage* img;
@end

@interface ImagePrefetcher ()
@property (nonatomic, copy) AsynchPrefetchOnCompletion completionHandler;
@property (nonatomic, strong) QueueManager *qManager;
@property (nonatomic, strong) NSString *identifier;
@end

@implementation ImagePrefetcher

+ (instancetype)shared{
    static ImagePrefetcher *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [ImagePrefetcher new];
    });
    return _shared;
}

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(operationDone:) name:QueueManagerOperationStatusNotification object:nil];
        self.identifier = [NSUUID UUID].UUIDString;
        self.qManager = [[QueueManager alloc] initWithIdentifier:self.identifier maxConcurentItem:1];
    }
    return self;
}

- (void)prefetch:(NSArray<AsynchImage *> *)itemsToPrefetch onCompletion:(AsynchPrefetchOnCompletion)handler{
    if (self.completionHandler) {
        return;
    }
    self.completionHandler = handler;
    for (AsynchImage *item in itemsToPrefetch) {
        ImgOperation *opt = [ImgOperation new];
        opt.img = item;
        [self.qManager runOperation:opt];
    }
}

- (void) operationDone:(NSNotification*)notify{
    //identifier, status
    if ([self.identifier isEqualToString:notify.userInfo[@"identifier"]]) {
        NSNumber *status = notify.userInfo[@"status"];
        if (status.integerValue == QueueManagerStatusDone) {
            self.completionHandler(YES);
            self.completionHandler = nil;
        }
    }
}

@end

@implementation ImgOperation

- (void)execute{
    __weak typeof(self) weakSelf = self;
    [self.img fetch:^(UIImage * _Nullable img) {
        [weakSelf finish];
    }];
}

@end
