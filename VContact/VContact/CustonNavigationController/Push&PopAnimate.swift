//
//  Push&PopAnimate.swift
//  VContact
//
//  Created by Wally on 05.06.2022.
//

import UIKit

class PushAnimate: NSObject, UIViewControllerAnimatedTransitioning {
    let durationTimeAnimation: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        durationTimeAnimation
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(rotationAngle: .pi*3/2)
        
        UIView.animateKeyframes(withDuration: durationTimeAnimation,
                                delay: 0,
                                options: .calculationModeLinear,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6, animations: {
                source.view.transform = CGAffineTransform(scaleX: 0, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.7, animations: {
                let rotationView = CGAffineTransform(rotationAngle: .pi*2)
                destination.view.transform = rotationView
            })
        }, completion: {finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        })
    }
}

class PopAnimate: NSObject, UIViewControllerAnimatedTransitioning {
    let durationTimeAnimation: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        durationTimeAnimation
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animateKeyframes(withDuration: durationTimeAnimation,
                                delay: 0,
                                options: .calculationModeLinear,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6, animations: {
                source.view.transform = CGAffineTransform(rotationAngle: .pi*3/2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.5, animations: {
                destination.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: {finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        })
    }
}
