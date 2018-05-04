//
//  SkyfallRouter.swift
//  iOSAppKitExample
//
//  Created by Towhid Islam on 5/3/18.
//  Copyright © 2018 Towhid Islam. All rights reserved.
//

import UIKit
import NGAppKit

class CustomRouter: Router {
    
    override func createRoute(toViewController info: RouteTo) -> UIViewController {
        let routed = super.createRoute(toViewController: info)
        routed.transitioningDelegate = self
        return routed
    }
    
    override func route(from viewController: UIViewController?, withInfo info: NGObject?) {
        guard let info = info else{
            super.route(from: viewController, withInfo: nil)
            return
        }
        let updated = super.updateRoutingCount(info)
        super.route(from: viewController, withInfo: updated)
    }

    override func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let skyfall = CustomTransitioningAnimator()
        skyfall.reverse = true
        return skyfall
    }
    
    override func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let skyfall = CustomTransitioningAnimator()
        return skyfall
    }
}
