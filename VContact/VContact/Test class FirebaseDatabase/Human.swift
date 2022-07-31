//
//  Human.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 07.07.2022.
//

import Foundation
import Alamofire

struct Human: Codable {
    let name: String
    let gender: Bool
    let age: Int
    var dogs: [Dog]
    
    init (name: String, gender: Bool, age: Int, dogs: [Dog]){
        self .name = name
        self .gender = gender
        self.age = age
        self.dogs = dogs
    }
    
    init(dict: Any) throws {
        enum HumanInitError: Error {
            case invalidDictType
            case invalidNameType
            case invalidGenderType
            case invalidAgeType
            case invalidDogType
        }
        guard let dict = dict as? [String:Any] else {
           throw HumanInitError.invalidDictType
        }
        guard let name = dict["name"] as? String else {throw HumanInitError.invalidNameType}
        guard let gender = dict["gender"] as? Int else {throw HumanInitError.invalidGenderType}
        guard let age = dict["age"] as? Int else {throw HumanInitError.invalidAgeType}
        guard let dogsAnyArray = dict["dogs"] as? [Any] else {throw HumanInitError.invalidDogType}
        let dogs = dogsAnyArray.compactMap({try? Dog(dict: $0)})
        
        self.name = name
        self.gender = gender == 1
        self.age = age
        self.dogs = dogs
    }
    
    
    var toAnyObject: Any {
        ["name": name,
        "gender": gender,
        "age": age,
         "dogs": dogs.map({$0.toAnyObject})]
    }
    
}
