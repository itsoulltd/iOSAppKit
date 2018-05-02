//
//  AppInfo.m
//  StartUpProject
//
//  Created by Towhidul Islam on 12/20/16.
//  Copyright © 2016 Kite Games Studio. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

- (NSString *)stringValueForKey:(AppInfoKeys)key{
    id value = [[NSBundle mainBundle] infoDictionary][[self keyMapper:key]];
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }else if([value isKindOfClass:[NSNumber class]]){
        return [(NSNumber*)value stringValue];
    }
    return nil;
}

- (NSNumber *)numberValueForKey:(AppInfoKeys)key{
    id value = [[NSBundle mainBundle] infoDictionary][[self keyMapper:key]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    return nil;
}

- (NSString *)defaultStoryboardName{
    NSString *storyboardName = [[NSBundle mainBundle] infoDictionary][[self keyMapper:MainStoryboardName]];
    return storyboardName;
}

- (NSString*) keyMapper:(AppInfoKeys)key{
    NSString *result = @"";
    switch (key) {
        case MainStoryboardName:
            result = @"UIMainStoryboardFile";
            break;
        case BundleName:
            result = @"CFBundleName";
            break;
        case BundleIdentifier:
            result = @"CFBundleIdentifier";
            break;
        case BundleDisplayName:
            result = @"CFBundleDisplayName";
            break;
        case BuildVersion:
            result = @"CFBundleVersion";
            break;
        case Version:
            result = @"CFBundleShortVersionString";
            break;
        default:
            break;
    }
    return result;
}

@end
