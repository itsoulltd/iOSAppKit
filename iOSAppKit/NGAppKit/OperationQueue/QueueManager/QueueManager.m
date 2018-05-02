//
//  QueueManager.m
//  NGOperationQueue
//
//  Created by Towhid Islam on 6/10/17.
//  Copyright © 2017 Towhid Islam. All rights reserved.
//

#import "QueueManager.h"

@interface QueueManager () <OperationGroupDelegate>
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *groupDictionary;
@end

@implementation QueueManager

NSNotificationName const QueueManagerOperationStatusNotification = @"QueueManagerOperationStatusNotification";

- (instancetype) initWithIdentifier:(NSString*)identifier maxConcurentItem:(NSInteger)count{
    if (self = [super init]) {
        self.identifier = identifier;
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = count;
        [self.queue addObserver:self forKeyPath:@"suspended" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.queue addObserver:self forKeyPath:@"operationCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld  context:nil];
    }
    return self;
}

- (void)dealloc{
    [self.queue removeObserver:self forKeyPath:@"operationCount"];
    [self.queue removeObserver:self forKeyPath:@"suspended"];
}

- (NSMutableDictionary *)groupDictionary{
    if (_groupDictionary == nil) {
        _groupDictionary = [NSMutableDictionary new];
    }
    return _groupDictionary;
}

- (BOOL)addGroup:(OperationGroup *)group{
    BOOL isExist = self.groupDictionary[group.identifier] != nil;
    if (isExist == NO) {
        @synchronized (self) {
            self.groupDictionary[group.identifier] = group;
        }
        group.delegate = self;
    }
    return !isExist;
}

- (void)runGroup:(OperationGroup *)group{
    if ([self addGroup:group]) {
        [group enqueueIntoQueue:self.queue];
    }
}

- (void)runOperation:(AsynchOperation *)opt{
    [self.queue addOperation:opt];
}

- (void)suspend{
    if (self.queue.isSuspended == NO) {
        [self.queue setSuspended:YES];
    }
}

- (void)resume{
    if (self.queue.isSuspended == YES) {
        [self.queue setSuspended:NO];
    }
}

- (void)cancelGroups:(NSArray<NSString *> *)identifiers{
    [self suspend];
    for (NSString *identifier in identifiers) {
        OperationGroup *group = self.groupDictionary[identifier];
        [group cancel];
    }
    [self resume];
}

#pragma Queue OperationCount Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //
    if ([keyPath isEqualToString:@"operationCount"]) {
        //NSNumber *oldVal = change[NSKeyValueChangeOldKey];
        NSNumber *newVal = change[NSKeyValueChangeNewKey];
        if (newVal.integerValue <= 0) {
            NSLog(@"Operation Queue Done Here");
            self.status = QueueManagerStatusDone;
            [[NSNotificationCenter defaultCenter] postNotificationName:QueueManagerOperationStatusNotification object:nil userInfo:@{@"identifier":self.identifier, @"status":[NSNumber numberWithInteger:QueueManagerStatusDone]}];
        }else{
            NSLog(@"Operation Queue Running");
            self.status = QueueManagerStatusRunning;
            [[NSNotificationCenter defaultCenter] postNotificationName:QueueManagerOperationStatusNotification object:nil userInfo:@{@"identifier":self.identifier, @"status":[NSNumber numberWithInteger:QueueManagerStatusRunning]}];
        }
    }
    
    if ([keyPath isEqualToString:@"suspended"]) {
        //NSNumber *oldVal = change[NSKeyValueChangeOldKey];
        NSNumber *newVal = change[NSKeyValueChangeNewKey];
        if (newVal.boolValue) {
            NSLog(@"Operation Queue Suspended");
            self.status = QueueManagerStatusSuspend;
            [[NSNotificationCenter defaultCenter] postNotificationName:QueueManagerOperationStatusNotification object:nil userInfo:@{@"identifier":self.identifier, @"status":[NSNumber numberWithInteger:QueueManagerStatusSuspend]}];
        }else{
            NSLog(@"Operation Queue Resumed");
        }
    }
}

#pragma OperationGroupDelegate

- (void)operationGroupDidFinish:(NSString *)identifier{
    BOOL isExist = self.groupDictionary[identifier] != nil;
    if (isExist) {
        @synchronized (self) {
            [self.groupDictionary removeObjectForKey:identifier];
        }
    }
}

@end
