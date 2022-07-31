//
//  ShadowForAvatar.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 20.05.2022.
//

import UIKit

class ShadowForAvatar: UIView {
 
    @IBOutlet var shadowView: UIView!
    @IBOutlet var avatar: UIImageView!
    
    
    @IBInspectable var widthShadow: CGFloat = 10
    @IBInspectable var opacityShadow: Float = 0.8
    @IBInspectable var colorShadow = UIColor.black
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()

        shadowView.layer.masksToBounds = false
        shadowView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shadowView.layer.shadowColor = colorShadow.cgColor
        shadowView.layer.shadowRadius = widthShadow
        shadowView.layer.shadowOpacity = opacityShadow
    
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        avatar.layer.cornerRadius = bounds.height/2
        shadowView.layer.cornerRadius = bounds.height/2
        avatar.layer.masksToBounds = true
    }
    
}
