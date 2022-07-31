//
//  CustomNavigationController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 05.06.2022.
//

import UIKit

class CustomeInteractiveTransition: UIPercentDrivenInteractiveTransition{
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomeInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let panScreenGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanScreenAdge(_:)))
        panScreenGR.edges = .left
        self.view.addGestureRecognizer(panScreenGR)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
            
        case .none:
            return nil
        case .push:
            return PushAnimate()
        case .pop:
            return PopAnimate()
        @unknown default:
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc func handlePanScreenAdge (_ recognize: UIScreenEdgePanGestureRecognizer) {
        
        switch recognize.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
//            расчитаем размер экрана
            guard let widthScreen = recognize.view?.frame.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
//            расчитываем растояние, которое протянул пользователь
            let distanseGesture = recognize.translation(in: recognize.view)
            let relativeTranslation = distanseGesture.x / widthScreen
            let persent = max(0, min(1,relativeTranslation))
            interactiveTransition.update(persent)
            interactiveTransition.shouldFinish = persent > 0.45

        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()

        default:
            break
        }
    }
    
}
