//
//  NewCustomeClass.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 16.07.2022.
//

import Foundation
import UIKit
import RealmSwift

// MARK: Friends
class ResponseFriendNew: Decodable {
    var response: ItemsFriendsNew
}

class ItemsFriendsNew: Decodable {
    var items: [FriendsNew]
}

class FriendsNew: Object, Decodable {
    @Persisted var idUser: Int = 0
    @Persisted var name: String = ""
    @Persisted var familyName: String = ""
    @Persisted var photoURL: String = ""
    var avatar: UIImageView = UIImageView(image: UIImage(imageLiteralResourceName: "Mikky"))
    
    enum MainCodingKeys: String, CodingKey {
        case idUser = "id"
        case name = "first_name"
        case familyName = "last_name"
        case photoURL = "photo_100"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        do {
            let value = try decoder.container(keyedBy: MainCodingKeys.self)
            self.idUser = try value.decode(Int.self, forKey: .idUser)
            self.name = try value.decode(String.self, forKey: .name)
            self.familyName = try value.decode(String.self, forKey: .familyName)
            self.photoURL = try value.decode(String.self, forKey: .photoURL)
        } catch {
            print (error.localizedDescription)
        }
    }
    override static func primaryKey() -> String? {
        "idUser"
    }
}
// MARK: PHOTOS FRIENDS
class FriendsPhotosResponse: Decodable {
    var response: FriendsPhotosItems
}

class FriendsPhotosItems: Decodable {
    var items: [FriendsPhotos]
}

class FriendsPhotos: Decodable {
    var id: Int = 0
    var date: Int = 0
    var url: String = ""
    
    enum MainCodingKeys: String, CodingKey {
        case id, date, sizes
    }
    enum SizeCodingKeys: String, CodingKey {
        case url
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let value = try decoder.container(keyedBy: MainCodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.date = try value.decode(Int.self, forKey: .date)
        var sizeValue = try value.nestedUnkeyedContainer(forKey: .sizes)
        let _ = try sizeValue.nestedContainer(keyedBy: SizeCodingKeys.self)
        let _ = try sizeValue.nestedContainer(keyedBy: SizeCodingKeys.self)
        let _ = try sizeValue.nestedContainer(keyedBy: SizeCodingKeys.self)
        let fourthSizeValue = try sizeValue.nestedContainer(keyedBy: SizeCodingKeys.self)
        self.url = try fourthSizeValue.decode(String.self, forKey: .url)
    }
}
