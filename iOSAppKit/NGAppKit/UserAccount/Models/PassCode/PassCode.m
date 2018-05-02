//
//  PassCode.m
//  NGAppKit
//
//  Created by Towhidul Islam on 3/1/17.
//  Copyright © 2017 Towhidul Islam. All rights reserved.
//

#import "PassCode.h"
#import "KeychainWrapper.h"

@interface PassCode (){
    NSString *_passwordKey;
}

@end

@implementation PassCode

- (NSString*) appBundleIdentifier{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *key = (__bridge NSString*)kCFBundleIdentifierKey;
    return [infoDic objectForKey:key];
}

- (instancetype)initWithKeychainIdentifier:(NSString *)identifier{
    if (self = [super init]) {
        _passwordKey = identifier;
    }
    return self;
}

- (NSString *)passwordKey{
    if (_passwordKey == nil) {
        _passwordKey = [NSString stringWithFormat:@"%@_%@Key", [self appBundleIdentifier], NSStringFromClass([self class])];
    }
    return _passwordKey;
}

- (NSString *)getPin{
    return [KeychainWrapper keychainStringFromMatchingIdentifier:self.passwordKey];
}

- (void)setPin:(NSString *)pin{
    
    if (pin == nil) {
        return;
    }
    if ([KeychainWrapper createKeychainValue:pin forIdentifier:self.passwordKey]) {
        NSLog(@"PassCode Successfully Saved into KeyChain");
    }
}

- (BOOL)matchPin:(NSString *)pin{
    if ([self getPin] == nil) {
        return NO;
    }
    BOOL isMatched = [pin isEqualToString:[self getPin]];
    return isMatched;
}

- (void)remove{
    [KeychainWrapper deleteItemFromKeychainWithIdentifier:[self passwordKey]];
}




@end
