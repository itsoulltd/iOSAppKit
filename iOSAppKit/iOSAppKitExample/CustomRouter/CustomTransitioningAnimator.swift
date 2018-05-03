//
//  SkyfallModalAnimator.swift
//  OfflineDrive
//
//  Created by Towhid Islam on 7/25/15.
//  Copyright (c) 2015 Towhid Islam. All rights reserved.
//

import Foundation
import UIKit

class CustomTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    
    var reverse: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.30 //
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        if reverse == false{
            
            toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)
            containerView.addSubview(toViewController.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
                
                fromViewController.view.alpha = 0.5
                toViewController.view.frame = finalFrameForVC
                }, completion: { finished in
                    
                    fromViewController.view.alpha = 1.0
                    transitionContext.completeTransition(true)
            })
        }
        else{
            
            toViewController.view.frame = finalFrameForVC
            toViewController.view.alpha = 0.5
            containerView.addSubview(toViewController.view)
            containerView.sendSubview(toBack: toViewController.view)
            
            let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: false)!
            snapshot.frame = fromViewController.view.frame
            containerView.addSubview(snapshot)
            let snapshotFinalFrame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)
            
            fromViewController.view.removeFromSuperview()
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
                
                snapshot.frame = snapshotFinalFrame
                toViewController.view.alpha = 1.0
                }, completion: { finished in
                    
                    snapshot.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
    }
}
