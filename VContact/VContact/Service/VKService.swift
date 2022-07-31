//
//  VKService.swift
//  VContact
//
//  Created by Wally on 15.06.2022.
//

import Foundation
import Alamofire
import Kingfisher
import RealmSwift
import UIKit
import FirebaseDatabase

class VKService {

    private var fireBaseDatabaseToken: DatabaseHandle?
    
    enum Methods: String {
        case friends = "/method/friends.get"
        case photo = "/method/photos.getAll"
        case getGroups = "/method/groups.get"
        case searchGroup = "/method/groups.search"
        case user = "/method/users.get"
        case newsfeed = "/method/newsfeed.get"
    }
    
    func getURL (requestMethod: Methods) -> URLComponents {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.path =  requestMethod.rawValue
        url.queryItems = [URLQueryItem(name: "user-id", value: Session.user.userID),
                          URLQueryItem(name: "v", value: "5.131"),
                          URLQueryItem(name: "access_token", value: Session.user.token)]
        var extraQueryItem = URLQueryItem(name: "", value: "")
        if requestMethod == .friends {
            extraQueryItem = URLQueryItem(name: "fields", value: "first_name, photo_100")
        } else if requestMethod == .getGroups {
            extraQueryItem = URLQueryItem(name: "extended", value:  "1")
        } else if requestMethod == .photo {
            extraQueryItem = URLQueryItem(name: "owner_id", value:  "wall")
        } else if requestMethod == .newsfeed {
            extraQueryItem = URLQueryItem(name: "filters", value: "post")
        }
        url.queryItems?.append(extraQueryItem)
        return url
    }
    
    func getFriendsPhotos(owner_id: String, compilition: @escaping ([UIImageView]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/photos.getAll") else { return }
        let parameters: Parameters = ["user-id": Session.user.userID,
                                        "v": "5.131",
                                      "access_token": Session.user.token,
                                      "owner_id": owner_id]
        
        Alamofire.request(url, method: .get ,parameters: parameters).responseJSON { data in
            guard let data = data.data else { return }
            do{
            let json = try JSONDecoder().decode(FriendsPhotosResponse.self, from: data)
                print(json)
                let photos = json.response.items

                var friendPhotos: [UIImageView] = []
                for photo in photos {
                    if let imageURL = URL(string: photo.url) {
                    let image = UIImageView()
                    image.kf.setImage(with: imageURL)
                        friendPhotos.append(image)
                    }
                }
                compilition(friendPhotos)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    MARK: Получаем и обрабатываем данные для сцены Friends.
//    func saveFriendsData(friends: [Friends]) {
//
////            MARK: Удалить при размещении
//            var configuration = Realm.Configuration.defaultConfiguration
//            configuration.deleteRealmIfMigrationNeeded = false
//        do {
//            let realm = try Realm(configuration: configuration)
//            let oldFriends = realm.objects(Friends.self)
//            realm.beginWrite()
//            realm.delete(oldFriends)
//            realm.add(friends)
//            try realm.commitWrite()
//
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func getFriends() {
//        let url = getURL(requestMethod: .friends)
//        Alamofire.request(url).responseJSON(completionHandler: {response in
//            guard let data = response.data else { return }
//            do {
//            let json = try JSONDecoder().decode(FriendsResponse.self, from: data)
//                let friendsArr = (json.response.items)
//                self.saveFriendsData(friends: friendsArr)
//            } catch {
//                Swift.print(error.localizedDescription)
//            }
//        })
//    }
    
    func saveFriendsNew(friends: [FriendsNew]) {
        do {
            var configuration = Realm.Configuration.defaultConfiguration
            configuration.deleteRealmIfMigrationNeeded = true
            let realm = try Realm(configuration: configuration)
            let oldEntity = realm.objects(FriendsNew.self)
            try realm.write({
                realm.delete(oldEntity)
                realm.add(friends, update: .all)
            })
            if let urlFile = realm.configuration.fileURL {
                print(urlFile)
            }
        } catch {
            print (error.localizedDescription)
        }
    }
    
    
    func getFriendsNew(compilation: @escaping () -> Void) {
        let url = getURL(requestMethod: .friends)
        Alamofire.request(url).responseJSON {response in
            guard let data = response.data else { return }
            do {
            let json = try JSONDecoder().decode(ResponseFriendNew.self, from: data)
                let friendsArr = json.response.items
                self.saveFriendsNew(friends: friendsArr)
            compilation()
            } catch {
                Swift.print(error.localizedDescription)
            }
        }
    }
    
    func getAvatarImage(friend: FriendsNew) -> UIImageView? {
                guard let url = URL(string: friend.photoURL) else { return nil }
        let avatar = UIImageView()
        avatar.kf.setImage(with: url)
        return avatar
    }
    
    
//    func getUsersIdInfo(complation: @escaping ([UserWithAvatar]) -> Void) {
//        var friendsArrayWithID: [Friends] = []
//        getFriends(completion: {friends in
//            friendsArrayWithID = friends})
//
//            for friend in friendsArrayWithID {
//                var urlUser = URLComponents()
//                urlUser.scheme = "https"
//                urlUser.host = "api.vk.com"
//                urlUser.path = Methods.user.rawValue
//                urlUser.queryItems = [
//                    URLQueryItem(name: "user_ids", value: String(friend.id)),
//                    URLQueryItem(name: "v", value: "5.81"),
//                    URLQueryItem(name: "access_token", value: Session.user.token),
//                    URLQueryItem(name: "fields", value: "photo_50")
//                ]
//                Alamofire.request(urlUser).responseJSON(completionHandler: {response in
//                    guard let data = response.data else { return }
//                    do {
//                        let json = try JSONDecoder().decode(UserWithAvatarResponse.self, from: data)
//                        complation(json.response)
//                    } catch {
//                        print (error.localizedDescription)
//                    }
//                })
//            }
//    }
//
//    func getAvatarUser(user: UserWithAvatar, complation: (UIImageView) -> Void) {
//        let urlPhoto = URL(string: user.urlPhoto)
//        let avatarImage = UIImageView()
//            avatarImage.kf.setImage(with: urlPhoto)
//            complation(avatarImage)
//    }
//    func savePhotoData(photos: [Photos]) {
//        do {
//        let realm = try Realm()
//            let oldPhotos = realm.objects(Photos.self)
//        try realm.write({
//            realm.delete(oldPhotos)
//            realm.add(photos)
//            print(realm.configuration.fileURL)
//        })
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
//    func getCollectionPhotos(completion: @escaping () -> Void) {
//        let url = getURL(requestMethod: .photo)
//        Alamofire.request(url).responseJSON(completionHandler: {response in
//            guard let data = response.data else { return }
//            do{
//            let json = try JSONDecoder().decode(PhotosResponse.self, from: data)
//            let photosArray = json.response.items
//            self.savePhotoData(photos: photosArray)
//            completion()
//            } catch {
//                print(error.localizedDescription)
//            }
//        })
//    }
    
//    func getImageViewPhoto(photos: [Photos], complation: @escaping ([UIImageView]) -> Void) {
//        var arrayPhotoImage = [UIImageView]()
//        for photo in photos {
//           let usr = URL(string: photo.url)
//            let imagePhoto = UIImageView()
//            imagePhoto.kf.setImage(with: usr)
//            arrayPhotoImage.append(imagePhoto)
//        }
//        complation(arrayPhotoImage)
//    }
    
    func saveGroupsData(groups: [Group]) {
        do {
//        var configuretion = Realm.Configuration.defaultConfiguration
//        configuretion.deleteRealmIfMigrationNeeded = true
        let realm = try Realm()
        let oldGroups = realm.objects(Group.self)
        try realm.write({
            realm.delete(oldGroups)
            realm.add(groups)
        })
        } catch {
            print(error.localizedDescription)
        }
    }
        func getCollectionGroups() {
            let url = getURL(requestMethod: .getGroups)
            Alamofire.request(url).responseJSON(completionHandler: {response in
                guard let data = response.data else { return }
                do {
                    let json = try JSONDecoder().decode(GroupsResponse.self, from: data)
                    let groups = json.response.items
                    if let userID = Int(Session.user.userID) {
                        self.userGroupsDatabase(userId: userID, groups: groups)}
                    var groupsFromAPI: [Group] = [Group(title: "KiteSerfing", selected: true), Group(title: "Cosmos", selected: false),Group(title: "Programming", selected: true),Group(title: "Serfing", selected: true),Group(title: "Formula1", selected: false)]
                    groups.forEach({ group in
                        let result = Group(title: group.titles, selected: false)
                        groupsFromAPI.append(result)
                    })
                    self.saveGroupsData(groups: groupsFromAPI)
                    
                } catch {
                    print(error.localizedDescription)
                }
            })
        }
    
    private func userGroupsDatabase(userId: Int, groups: [Groups]) {
        let user = Friends()
        user.id = userId
        user.groups = groups
        let userAnyObject = user.toAnyObject
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(userAnyObject)
        let dbConnect = Database.database(url: "https://vkcontact-36e1e-default-rtdb.europe-west1.firebasedatabase.app").reference()
        dbConnect.child(String(userId)).setValue(userAnyObject)
//        fireBaseDatabaseToken = dbConnect.child(String(userId)).observe(DataEventType.value, with: {snapshot in
//            guard let value = snapshot.value else { return }
//            let user = Friends(id: userId, first_name: <#T##String#>, last_name: <#T##String#>, dict: <#T##Any#>)
//        })
    }
    
    func getNewsfeed(complation: @escaping ([NewsJson]) -> Void) {
        let url = getURL(requestMethod: .newsfeed)
        
        Alamofire.request(url).responseJSON(completionHandler: {response in
            guard let data = response.data else { return }
            
            print(data.description)
            do {
                let json = try JSONDecoder().decode(NewsResponse.self, from: data)
                let newsJson = json.response.items
                print(newsJson.count)
                complation (newsJson)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    
    
    }



