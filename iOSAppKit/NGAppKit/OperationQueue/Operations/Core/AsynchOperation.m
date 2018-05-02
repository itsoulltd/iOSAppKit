//
//  AsynchOperation.m
//  NGAppKit
//
//  Created by Towhid Islam on 6/7/17.
//  Copyright © 2017 Towhidul Islam. All rights reserved.
//

#import "AsynchOperation.h"

@interface AsynchOperation (){
    BOOL _executing;
    BOOL _finished;
}
@property (nonatomic, strong) NSString *identifier;
@end

@implementation AsynchOperation

- (NSString *)identifier{
    if (_identifier == nil) {
        _identifier = [NSUUID UUID].UUIDString;
    }
    return _identifier;
}

- (BOOL)isAsynchronous{
    return YES;
}

- (BOOL)isExecuting{
    return _executing;
}

- (BOOL)isFinished{
    return _finished;
}

- (void) setExecutingValue:(BOOL)val{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = val;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void) setFinishedValue:(BOOL)val{
    [self willChangeValueForKey:@"isFinished"];
    _finished = val;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)start{
    if (self.isCancelled) {
        [self setFinishedValue:YES];
        return;
    }
    [self setExecutingValue:YES];
    [self execute];
}

- (void)finish{
    [self setExecutingValue:NO];
    [self setFinishedValue:YES];
}

- (void)execute{
    NSLog(@"Please Override in sub class.");
    NSLog(@"Executing");
    [self finish];
}

@end
