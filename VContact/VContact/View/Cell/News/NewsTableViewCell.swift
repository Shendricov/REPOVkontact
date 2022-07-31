//
//  NewsTableViewCell.swift
//  VContact
//
//  Created by Wally on 23.05.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var avatarPhoto: UIImageView!
    @IBOutlet var shadowForAvatar: UIView!
    @IBOutlet var nameUser: UILabel!
    @IBOutlet var dateNews: UILabel!
    @IBOutlet var textNews: UILabel!
    @IBOutlet var imageNews: UIImageView!
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var countLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
