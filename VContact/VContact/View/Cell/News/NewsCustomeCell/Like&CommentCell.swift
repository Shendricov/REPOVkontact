//
//  Like&CommentCell.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 31.07.2022.
//

import UIKit

class Like_CommentCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    private var numberOfLikes: Int = 0
    @IBOutlet weak var comment: UILabel?
    @IBOutlet weak var commetsCount: UILabel?
    private var numberOfComments: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeCount.text = String(numberOfLikes)
        likeImage.image = UIImage(systemName: "heart")
        likeImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        commetsCount?.text = String(numberOfComments)
        
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tapLike()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tapLike()
    }
    
    func tapLike() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLikeRecognize(_:)))
        addGestureRecognizer(tap)
    }
    @objc func tapLikeRecognize(_ gestureRecognise: UITapGestureRecognizer) {
        if numberOfLikes == 0 {
            likeImage?.image = UIImage(systemName: "heart.fill")
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           animations: {
                self.likeImage.transform = CGAffineTransform(scaleX: -1, y: -1)
                self.likeImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                self.likeImage.transform = .identity
            })
            numberOfLikes = 1
            self.likeCount.text = String(numberOfLikes)
        } else {
            likeImage.image = UIImage(systemName: "heart")
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           animations: {
                self.likeImage.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                self.likeImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                self.likeImage.transform = .identity
            })
            numberOfLikes = 0
            self.likeCount.text = String(numberOfLikes)
        }
    }
}
