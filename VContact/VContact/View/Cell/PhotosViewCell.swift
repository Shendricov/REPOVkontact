//
//  CollectionViewCell.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 10.05.2022.
//

import UIKit

class PhotosViewCell: UICollectionViewCell {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var heardImage: UIImageView!
    @IBOutlet weak var countLike: UILabel!
    private var numberLikesTap: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLike.text = String(numberLikesTap)
//        rootView.layer.cornerRadius = rootView.frame.height/2
//        rootView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        rootView.layer.shadowOffset = .zero
//        rootView.layer.shadowOpacity = 1
//        rootView.layer.shadowRadius = 10
        
//        photoImage.layer.cornerRadius = photoImage.frame.height/2
//        photoImage.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLike()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLike()
    }
    
    private func setupLike() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLike(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func tapLike(_ gestureRecognise: UITapGestureRecognizer) {
        if numberLikesTap == 0 {
            heardImage.image = .init(systemName: "heart.fill")
           
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           animations: {
                self.heardImage.transform = CGAffineTransform(scaleX: -1, y: -1)
                self.heardImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                self.heardImage.transform = .identity
            })
            numberLikesTap = 1
            countLike.text = String(numberLikesTap)
        } else {
            heardImage.image = .init(systemName: "heart")
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           animations: {
                self.heardImage.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                self.heardImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                self.heardImage.transform = .identity
            })
            numberLikesTap = 0
            countLike.text = String(numberLikesTap)
        }
    }
    
}

class LikeViewControl: UIControl {
   
    /*
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 20))
        path.addLine(to: CGPoint(x: 10, y: 10))
        path.addArc(withCenter: CGPoint(x: 15, y: 10), radius: 5, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 25, y: 10), radius: 5, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        path.close()
        
        context?.addPath(path)
    }
    */
    
}
