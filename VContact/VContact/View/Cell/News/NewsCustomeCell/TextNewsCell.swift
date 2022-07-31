//
//  TextNewsCell.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 31.07.2022.
//

import UIKit

class TextNewsCell: UITableViewCell {

    @IBOutlet weak var textOfNews: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
