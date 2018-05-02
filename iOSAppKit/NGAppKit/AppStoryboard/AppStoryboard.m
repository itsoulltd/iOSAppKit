//
//  AppStoryboard.m
//  StartUpProject
//
//  Created by Towhidul Islam on 12/20/16.
//  Copyright © 2016 Kite Games Studio. All rights reserved.
//

#import "AppStoryboard.h"
#import "AppInfo.h"

@interface AppStoryboard ()
@property (nonatomic, strong) UIStoryboard *internalStoryboard;
@property (nonatomic, strong) NSMutableDictionary<NSString *, UIStoryboard *> *storyboardContainer;
@end

@implementation AppStoryboard

+ (instancetype)load:(NSString *)name{
    static AppStoryboard *inner = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inner = [AppStoryboard new];
        inner.storyboardContainer = [NSMutableDictionary new];
    });
    if (name == nil) {
        name = [[AppInfo new] defaultStoryboardName];
    }
    UIStoryboard *board = (UIStoryboard*)[inner storyboardContainer][name];
    if (board == nil) {
        board = [UIStoryboard storyboardWithName:name bundle:[NSBundle bundleForClass:[AppStoryboard class]]];
        [inner storyboardContainer][name] = board;
    }
    inner.internalStoryboard = board;
    return inner;
}

+ (instancetype)create:(NSString *)name{
    static NSMutableDictionary<NSString *, UIStoryboard *> *innerContainer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        innerContainer = [NSMutableDictionary new];
    });
    AppStoryboard *inner = [AppStoryboard new];
    if (name == nil) {
        name = [[AppInfo new] defaultStoryboardName];
    }
    UIStoryboard *board = (UIStoryboard*)innerContainer[name];
    if (board == nil) {
        board = [UIStoryboard storyboardWithName:name bundle:[NSBundle bundleForClass:[AppStoryboard class]]];
        innerContainer[name] = board;
    }
    inner.internalStoryboard = board;
    return inner;
}

- (UIViewController *)initialViewController{
    UIViewController *initial = [[self internalStoryboard] instantiateInitialViewController];
    return initial;
}

- (UIViewController *)viewControllerByType:(Class)type{
    return [self viewControllerByStoryboardID:NSStringFromClass(type)];
}

- (UIViewController *)viewControllerByStoryboardID:(NSString *)storyboardID{
    return [[self internalStoryboard] instantiateViewControllerWithIdentifier:storyboardID];
}

+ (UIViewController *)visibleViewController{
    UIViewController *rootViewController = [UIApplication.sharedApplication.keyWindow rootViewController];
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController*)rootViewController visibleViewController];
    }else if ([rootViewController isKindOfClass:[UITabBarController class]]){
        return [(UITabBarController*)rootViewController selectedViewController];
    }
    return rootViewController;
}

+ (void) showViewController:(UIViewController*)viewController sender:(id)sender{
    UIViewController *visible = [AppStoryboard visibleViewController];
    if ([visible respondsToSelector:@selector(showViewController:sender:)]) {
        [visible showViewController:viewController sender:sender];
    }else{
        if ([visible isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)visible pushViewController:viewController animated:YES];
        }else{
            [self showModalViewController:viewController onCompletion:nil];
        }
    }
}

+ (void) pushToLast:(UIViewController*)viewController sender:(id)sender{
    UIViewController *visible = [AppStoryboard visibleViewController];
    if ([visible isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)visible;
        NSMutableArray *viewsControllers = [[NSMutableArray alloc] initWithArray:nav.viewControllers];
        [viewsControllers removeLastObject];
        [viewsControllers addObject:viewController];
        [nav setViewControllers:viewsControllers animated:YES];
    }
}

+ (void) pushToLast:(UIViewController*)viewController replacing:(NSInteger)count sender:(id)sender{
    UIViewController *visible = [AppStoryboard visibleViewController];
    if ([visible isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)visible;
        NSMutableArray *viewsControllers = [[NSMutableArray alloc] initWithArray:nav.viewControllers];
        if (count < viewsControllers.count) { //never empty the Navigation stack
            for (NSInteger round = 0; round < count; round++) {
                [viewsControllers removeLastObject];
            }
        }
        [viewsControllers addObject:viewController];
        [nav setViewControllers:viewsControllers animated:YES];
    }
}

+ (void) showModalViewController:(UIViewController*)viewController onCompletion:(void (^)(void))block{
    UIViewController *visible = [AppStoryboard visibleViewController];
    viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [visible presentViewController:viewController animated:YES completion:block];
}

@end
