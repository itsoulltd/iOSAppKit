//
//  Router.m
//  NGAppKit
//
//  Created by Towhidul Islam on 11/29/17.
//  Copyright © 2017 ITSoulLab. All rights reserved.
//

#import "Router.h"
#import "AppStoryboard.h"

@interface Router()
@property (nonatomic, strong, readwrite) id<RouterProtocol> nextRouter;
@end

@implementation Router

NSString* const kRouteCount = @"RouteCountKey";

- (instancetype)initWithNext:(id<RouterProtocol>)next{
    if (self = [super init]) {
        self.nextRouter = next;
    }
    return self;
}

- (void)dealloc{
    NSLog(@"dealloc %@", NSStringFromClass([self class]));
}

- (NGObject *)updateRoutingCount:(NGObject *)info{
    if (info == nil) {
        info = [NGObject new];
        [info setValue:@(0) forKey:kRouteCount];
    }
    else if ([info valueForKey:kRouteCount] == nil){
        [info setValue:@(0) forKey:kRouteCount];
    }else{
        NSNumber *val = [info valueForKey:kRouteCount];
        val = [NSNumber numberWithInteger:(val.integerValue + 1)];
        [info setValue:val forKey:kRouteCount];
    }
    return info;
}

- (UIViewController*) createRouteToViewController:(RouteTo*)rInfo{
    NSAssert(rInfo.storyboard, @"#storyboard must not nil");
    NSAssert(rInfo.viewControllerID, @"#viewControllerID must not nil");
    AppStoryboard *board = [AppStoryboard load:rInfo.storyboard];
    NSString *iPadID = (rInfo.viewControllerIPadID == nil) ? rInfo.viewControllerID : rInfo.viewControllerIPadID;
    UIViewController *routedVC = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? [board viewControllerByStoryboardID:iPadID] : [board viewControllerByStoryboardID:rInfo.viewControllerID];
    return routedVC;
}

- (void)routeFrom:(UIViewController *)viewController withInfo:(NGObject *)info{
    if ([info isKindOfClass:[RouteTo class]]) {
        UIViewController *routedVC = [self createRouteToViewController:(RouteTo*)info];
        [viewController showViewController:routedVC sender:nil];
    }
}

- (void)routeFrom:(UIViewController *)viewController withInfo:(NGObject *)info animated:(BOOL)animate onCompletion:(void (^)(void))completion{
    if ([info isKindOfClass:[RouteTo class]]) {
        if (completion) {
            UIViewController *routedVC = [self createRouteToViewController:(RouteTo*)info];
            [viewController presentViewController:routedVC animated:animate completion:completion];
        }else{
            [self routeFrom:viewController withInfo:info];
        }
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return nil;
}

@end

@implementation RouteTo
@end
