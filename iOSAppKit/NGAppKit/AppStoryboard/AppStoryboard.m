//
//  AppStoryboard.m
//  StartUpProject
//
//  Created by Towhidul Islam on 12/20/16.
//  Copyright © 2016 ITSoulLab. All rights reserved.
//

#import "AppStoryboard.h"
#import "AppInfo.h"

@interface AppStoryboard ()
@property (nonatomic, weak) UIApplication *application;
@property (nonatomic, weak) NSBundle *mainBundle;
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
    if (name == nil && inner.mainBundle != nil) {
        name = [inner.mainBundle infoDictionary][[[AppInfo new] stringValueForKey:MainStoryboardName]];
    }
    if (name == nil){
        return inner;
    }
    UIStoryboard *board = (UIStoryboard*)[inner storyboardContainer][name];
    if (board == nil) {
        board = [UIStoryboard storyboardWithName:name bundle:inner.mainBundle];
        [inner storyboardContainer][name] = board;
    }
    inner.internalStoryboard = board;
    return inner;
}

- (UIViewController *)initialViewController{
    UIViewController *initial = [[self internalStoryboard] instantiateInitialViewController];
    return initial;
}

+ (NSString*) resolveClassName:(Class)type{
    NSString *fullName = NSStringFromClass(type);
    NSString *moduleName = [[AppInfo new] stringValueForKey:BundleName];
    NSString *moduleWithSeparetor = [NSString stringWithFormat:@"%@.",moduleName];
    NSString *className = [fullName stringByReplacingOccurrencesOfString:moduleWithSeparetor withString:@""];
    return className;
}

- (UIViewController *)viewControllerByType:(Class)type{
    return [self viewControllerByStoryboardID:[AppStoryboard resolveClassName:type]];
}

- (UIViewController *)viewControllerByStoryboardID:(NSString *)storyboardID{
    return [[self internalStoryboard] instantiateViewControllerWithIdentifier:storyboardID];
}

+ (void)configureApplication:(UIApplication *)app mainBundle:(NSBundle*)main{
    [AppStoryboard load:nil].application = app;
    [AppStoryboard load:nil].mainBundle = main;
}

+ (UIViewController *)visibleViewController{
    if ([AppStoryboard load:nil].application == nil) return nil;
    UIViewController *rootViewController = [[AppStoryboard load:nil].application.keyWindow rootViewController];
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController*)rootViewController visibleViewController];
    }else if ([rootViewController isKindOfClass:[UITabBarController class]]){
        return [(UITabBarController*)rootViewController selectedViewController];
    }
    return rootViewController;
}

+ (void) showModalViewController:(UIViewController*)viewController onCompletion:(void (^)(void))block{
    UIViewController *visible = [AppStoryboard visibleViewController];
    viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [visible presentViewController:viewController animated:YES completion:block];
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

+ (void) pushToLast:(UIViewController*)viewController sender:(id)sender{
    [AppStoryboard pushToLast:viewController replacing:1 sender:sender];
}

@end
