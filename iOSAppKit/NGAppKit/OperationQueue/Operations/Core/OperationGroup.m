//
//  UploadOperationGroup.m
//  NGAppKit
//
//  Created by Towhid Islam on 6/8/17.
//  Copyright © 2017 Towhidul Islam. All rights reserved.
//

#import "OperationGroup.h"

@interface OperationGroup ()
@property (nonatomic, strong) NSString *internalIdentifier;
@end

@implementation OperationGroup

- (NSString *)identifier{
    if (_internalIdentifier == nil) {
        _internalIdentifier = [NSUUID UUID].UUIDString;
    }
    return _internalIdentifier;
}

- (void)cancel{
    //
}

- (void)attachProgressBlock:(void (^)(double))progress{
    
}

- (void)enqueueIntoQueue:(NSOperationQueue *)queue{
    
}

@end
