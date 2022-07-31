//
//  SecondFuulScreenViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 01.06.2022.
//

import UIKit

class SecondFullScreenViewController: UIViewController {
        
    @IBOutlet var firstPhotoImageView: UIImageView!
    @IBOutlet var secondPhotoImageView: UIImageView!
    
    var photosArrayFullScreen: Array<UIImageView> = []
    
    private var animator: UIViewPropertyAnimator!
    
    private var onScreenImage: UIImageView!
    private var behindScreenImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onScreenImage = firstPhotoImageView
        behindScreenImage = secondPhotoImageView
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(workWithGestureRecognizer))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getStartPositionImage()
    
    }
    
    @objc func workWithGestureRecognizer(_ recogniser: UIPanGestureRecognizer) {
        switch recogniser.state {
            case .began:
                let swipeWay = recogniser.translation(in: view).x
                if swipeWay < 0 {
                    animator = UIViewPropertyAnimator(duration: 1,
                                                      curve: .linear,
                                                      animations: {
                        self.behindScreenImage.transform = CGAffineTransform(translationX: -(self.view.frame.width), y: 0)
                        self.onScreenImage.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                        self.view.bringSubviewToFront(self.behindScreenImage)
                    })
                    animator.pauseAnimation()
                    
                } else if swipeWay > 0 {
                    self.behindScreenImage.frame = self.onScreenImage.frame
                    self.behindScreenImage.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                    
                    animator = UIViewPropertyAnimator(duration: 1,
                                                      curve: .linear,
                                                      animations: {
                        self.onScreenImage.transform = CGAffineTransform(translationX: self.view.frame.width , y: 0)
                        self.behindScreenImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                        
                    })
                    animator.pauseAnimation()
                }
            case .changed:
                let widthScreen = self.view.frame.width
                let swipingProgres = recogniser.translation(in: view).x
                let relativelyProgress = swipingProgres / widthScreen
                let persent = max(0, min(1,relativelyProgress))
                animator.fractionComplete = persent
            
            case .ended:

                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
                animator.addCompletion({_ in
                    self.onScreenImage.transform = .identity
                    if self.onScreenImage == self.firstPhotoImageView {
                        self.onScreenImage = self.secondPhotoImageView
                        self.behindScreenImage = self.firstPhotoImageView
                    } else {
                        self.onScreenImage = self.firstPhotoImageView
                        self.behindScreenImage = self.secondPhotoImageView
                    }
                    
                    self.getStartPositionImage()
                })
                
                
                
            default:
                break
            }
       
    }
    
    private func getStartPositionImage () {
        let guide = view.safeAreaLayoutGuide
        let heightSafeArea = guide.layoutFrame.height
        onScreenImage.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.width, height: heightSafeArea )
        behindScreenImage.frame = CGRect(x: onScreenImage.frame.maxX, y: view.safeAreaInsets.top, width: view.frame.width, height: heightSafeArea)
    }
    
//    private func getConstraint() {
//
//    NSLayoutConstraint.activate([
//        onScreenImage.topAnchor.constraint(equalTo: view.topAnchor),
//        onScreenImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//        onScreenImage.widthAnchor.constraint(equalTo: view.widthAnchor),
//        onScreenImage.heightAnchor.constraint(equalTo: view.heightAnchor)])
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  
    
}
