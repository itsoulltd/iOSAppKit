//
//  Router.m
//  NewColorPop
//
//  Created by Towhidul Islam on 11/29/17.
//  Copyright © 2017 KITE GAMES STUDIO. All rights reserved.
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

- (void)routingViewController:(UIViewController *)viewController withInfo:(NGObject *)info{
    if ([info isKindOfClass:[RouterInfo class]]) {
        RouterInfo *rInfo = (RouterInfo*)info;
        AppStoryboard *board = [AppStoryboard load:rInfo.storyboard];
        UIViewController *routedVC = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? [board viewControllerByStoryboardID:rInfo.viewControllerIPadID] : [board viewControllerByStoryboardID:rInfo.viewControllerID];
        [viewController showViewController:routedVC sender:nil];
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

@implementation RouterInfo
@end
