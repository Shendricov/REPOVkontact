//
//  FullScreenPhotoViewController.swift
//  VContact
//
//  Created by Wally on 01.06.2022.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    private var indexPhoto: Int = 0
    var photosArrayFullScreen: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photosArrayFullScreen[0].image
        
        let panGestureRecognise = UIPanGestureRecognizer(target: self, action: #selector(workGestureRecognize(_:)))
        self.view.addGestureRecognizer(panGestureRecognise)
        
    }
    
    
    
    private var interactiveAnimator: UIViewPropertyAnimator!

    @objc func workGestureRecognize(_ recognizer: UIPanGestureRecognizer) {
             switch recognizer.state {
             case .began:
                    interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                                 curve: .linear,
                                                                 animations: {
                        let flippingCoordinateY3D = CATransform3DMakeRotation(.pi, 0, 1, 0)
                        self.photoImageView.transform = CATransform3DGetAffineTransform(flippingCoordinateY3D)
                        self.photoImageView.transform = .identity
                    })
                 self.interactiveAnimator.pauseAnimation()
            
             case .changed:
//                       находим ширину экрана.
//                 let widthScreen = self.view.frame.width
                 let swipingProgres = recognizer.translation(in: view).x
//                 let relativelyProgress = swipingProgres / widthScreen
//                 let persent = max(0, min(1,relativelyProgress))
//                 interactiveAnimator.fractionComplete = persent
             case .ended:
                 
                        if indexPhoto < photosArrayFullScreen.count - 1,
                           indexPhoto > 0 {
                            if recognizer.translation(in: view).x < 0 {
                                indexPhoto += 1
                            } else {
                                indexPhoto -= 1
                            }
                        } else if indexPhoto == 0 {
                            if recognizer.translation(in: view).x < 0 {
                                indexPhoto += 1
                            } else {
                                indexPhoto = self.photosArrayFullScreen.count - 1
                            }
                        } else {
                            indexPhoto = 0
                        }
                        
                 self.photoImageView.image = self.photosArrayFullScreen[indexPhoto].image
                 self.interactiveAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
                    
             default:
                 break
             }
        
        
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func toTheSecondFullScreen(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewDestination = storyboard.instantiateViewController(withIdentifier: "SecondFullScreenViewController") as! SecondFullScreenViewController
        viewDestination.photosArrayFullScreen = photosArrayFullScreen
        
        viewDestination.modalTransitionStyle = .flipHorizontal
        viewDestination.modalPresentationStyle = .fullScreen
    
        self.navigationController?.pushViewController(viewDestination, animated: true)
    }
    
    
}
