//
//  Dogs.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 07.07.2022.
//

import Foundation
import Alamofire

struct Dog: Codable {
    var name: String
    
    init (name: String) {
        self.name = name
    }
    
    init(dict: Any) throws {
        enum DogInitError: Error {
            case invalidDictType
            case invalidNameType
        }
        
        guard let dict = dict as? [String: Any] else {
            throw DogInitError.invalidDictType
        }
        guard let name = dict["name"] as? String else {
            throw DogInitError.invalidNameType
        }
        self.name = name
    }
    
    var toAnyObject: Any {
        ["name": name]
    }
}
