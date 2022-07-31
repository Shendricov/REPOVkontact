//
//  TableViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 07.07.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase


class TestViewController: UIViewController {
    
    private var reguestHadler: DatabaseHandle?
    private var reguestHandlerForDogs: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testFirebaseDatabase()
        
        func testFirebaseDatabase() {
            
            let ivanDogs = [Dog(name: "Шарик"),
                            Dog(name: "Бим")]
            
            let annaDogs = [Dog(name: "Дружок"),
                            Dog(name: "Барбос"),
                            Dog(name: "Бублик")]
            
            let ivan = Human(name: "Иван", gender: true, age: 25, dogs: ivanDogs)
            let anna = Human(name: "Анна", gender: false, age: 17, dogs: annaDogs)
            
            let data = [ivan, anna].map({$0.toAnyObject})
            
            let dbLink = Database.database(url: "https://vkcontact-36e1e-default-rtdb.europe-west1.firebasedatabase.app").reference()
            dbLink.child("Humans").setValue(data)
            // MARK:       получаем весь массив
            reguestHadler = dbLink.child("Humans").observe(DataEventType.value, with: { (snapshot) in
                            print(snapshot.value)
                //            Далее распарсим массив.
                guard let value = snapshot.value as? [Any] else { return }
                let humans: [Human] = value.compactMap {try? Human(dict: $0)}
                print(humans)
                
                //            MARK:  получаем отдельный элемент из массива.
                self.reguestHandlerForDogs = dbLink.child("Humans/0/dogs").observe(DataEventType.value, with: { snapshot in
                    guard let value = snapshot.value as? [Any] else { return }
                    let dogs = value.compactMap({try? Dog(dict: $0)})
                    print (dogs)
                })
//            MARK: добавляем какой либо элемент в базу данных.
                let plutoDog = Dog(name: "Плуто")
                dbLink.child("Humans/0/dogs").updateChildValues(["2": plutoDog.toAnyObject])
            })
        }
    }
}
