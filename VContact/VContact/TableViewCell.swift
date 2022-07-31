//
//  TableViewCell.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 07.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var title: UILabel!
    
//   используется в тех случаях, когда ячейка версталась в Interface Builder, а значит ее структура хранится либо в storyboard-файле, либо в xib-файле
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        Данный метод может быть использован, например, для того, чтобы произвести необходимые настройки графических элементов, размещенных в ячейке.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//        Данный метод можно использо- вать для создания различных анимаций внутри ячейки.
    }

}
