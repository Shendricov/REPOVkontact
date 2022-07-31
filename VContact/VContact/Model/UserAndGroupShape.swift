//
//  UserAndGroupShape.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 09.05.2022.
//

import Foundation
import UIKit
import RealmSwift

protocol UserProtocol {
    var first_name: String { get set }
    var last_name: String { get set }
    var avatar: UIImageView { get set }
//    var avatar: UIImage { get set }
//    var photos: [UIImage] { get set }
}

struct User: UserProtocol,Equatable {
    var first_name: String
    var last_name: String
    var avatar: UIImageView
//    var photos: [UIImage]
    
}

protocol GroupProtocol {
    var title: String { get set }
//    var avatar: UIImage { get set }
}

class Group: Object, GroupProtocol {
   @Persisted var title: String = ""
   @Persisted var selected: Bool = false
    convenience init(title: String, selected: Bool) {
        self.init()
        self.title = title
        self.selected = selected
    }
//    var avatar: UIImage
    
    
}

protocol NewsProtocol {
    var avatarPhoto: UIImage {get set}
    var nameUser: String {get set}
    var dateNews: String {get set}
    var textNews: String {get set}
    var imageNews: UIImage {get set}
    var likeImage: UIImage {get set}
    var countLike: Int {get set}
}

struct News: NewsProtocol {
    var avatarPhoto: UIImage
    var nameUser: String
    var dateNews: String
    var textNews: String
    var imageNews: UIImage
    var likeImage: UIImage
    var countLike: Int
}
