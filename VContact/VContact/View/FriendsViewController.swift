//
//  FriendsViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 29.05.2022.
//

import UIKit
import Alamofire
import RealmSwift

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewForSortLiteral: UIView!
//    private var friendsToken: NotificationToken?
    var arrayForTableViewHeader: [[FriendsNew]] {
        return getArrForTableView(usersArr: friendsNew)
    }
    let service = VKService()
    var friendsNew: [FriendsNew] = [] {
        didSet {
            friendsNew.sort(by: {$0.name < $1.name})
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = VKService()
        service.getFriendsNew {
            self.loadDataNew()
            self.tableView.reloadData()
        }
        let cellTypeNib = UINib(nibName: "PhotoNameCell", bundle: nil)
        self.tableView.register(cellTypeNib, forCellReuseIdentifier: "PhotoNameType")
    }
  
    private func globalLoad() {
        let group = DispatchGroup()
        group.enter()
        
    }
    
    func loadDataNew() {
        do{
            let realm = try Realm()
            let friends = realm.objects(FriendsNew.self)
            self.friendsNew = Array(friends)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
//    func loadData() {
//        do {
//            let realm = try Realm()
//            friendsResults = realm.objects(Friends.self)
//            friendsToken = friendsResults!.observe {response in
//                switch response {
//                case .initial:
//                    self.tableView.reloadData()
//                case .update(_,let deletions, let insertions, let modifications):
///*    Все изменения находятся внутри двух методов – self?.tableView.beginUpdates() и self?.tableView.endUpdates(). Это сделано, чтобы изменения применялись не по очереди а одновременно, единой транзакцией.
// */
//                    self.tableView.beginUpdates()
//                    self.tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    self.tableView.insertRows(at: insertions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    self.tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    self.tableView.endUpdates()
//                case .error(let error):
//                    print(error.localizedDescription)
//                }
//            }
//
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    private func getArrForTableView(usersArr: [FriendsNew]) -> [[FriendsNew]] {
        var result:[[FriendsNew]] = []
        var sectionsOfLetters: [Character] = []
        usersArr.forEach({ user in
            let letter = user.name.first!
            if !sectionsOfLetters.contains(letter) {
                sectionsOfLetters.append(letter)
            }
        })
        sectionsOfLetters.forEach({ letter in
            var tempuraryArr:[FriendsNew] = []
            for user in friendsNew {
                if user.name.first == letter {
                    tempuraryArr.append(user)
                }
            }
            result.append(tempuraryArr)
        })
        return result
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayForTableViewHeader.count
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForTableViewHeader[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNameType", for: indexPath) as! PhotoNameCell
        cell.avatar.image = self.service.getAvatarImage(friend: self.arrayForTableViewHeader[indexPath.section][indexPath.row])?.image
        
        cell.first_name.text = arrayForTableViewHeader[indexPath.section][indexPath.row].name
        cell.last_name.text = arrayForTableViewHeader[indexPath.section][indexPath.row].familyName
        cell.selectionStyle = .blue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let avatarAnimate = tableView.cellForRow(at: indexPath) as? PhotoNameCell else {
            return
        }
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveLinear,
                       animations: {
            avatarAnimate.avatar.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            avatarAnimate.avatarShadow.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            avatarAnimate.avatar.transform = .identity
            avatarAnimate.avatarShadow.transform = .identity
        },
                       completion: {_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewDestination = storyboard.instantiateViewController(withIdentifier: "PhotoFriendsScene") as! PhotosViewController
            let user = self.arrayForTableViewHeader[indexPath.section][indexPath.row]
            viewDestination.title = user.name
            let service = VKService()
            let user_id = String(user.idUser)
            service.getFriendsPhotos(owner_id: user_id) { photos in
            viewDestination.photosArray = photos }
               
            self.navigationController?.pushViewController(viewDestination, animated: true)
            
        })
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            let deletedUser = self.arrayForTableViewHeader[indexPath.section][indexPath.row]
            var index = 0
            for user in self.friendsNew {
                if user == deletedUser {
                    self.friendsNew.remove(at: index)
            }
            index += 1
            }})
        tableView.reloadData()
        let actionConfiguration = UISwipeActionsConfiguration(actions: [action])
        return actionConfiguration
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        здесь можно сократить код, если переделать массив в словарь.
        let getArr = arrayForTableViewHeader[section].first
        let firstName = getArr?.name
        let sectionLetter = firstName?.first
        return sectionLetter?.description
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  
        
//        let literalArr = ["a", "b", "c", "d", "e", "f"]
//        var arrButtonsLiteral: [UIButton] = []
//        var stackForButtons = UIStackView()
//
//        for literal in literalArr {
//            let button = UIButton()
//            NSLayoutConstraint.activate([
//                button.heightAnchor.constraint(equalToConstant: 20),
//                button.widthAnchor.constraint(equalToConstant: 20),
//            ])
//            button.setTitle(literal, for: .normal)
//            arrButtonsLiteral.append(button)
//        }
//        stackForButtons.axis = .vertical
//        stackForButtons.distribution = .equalCentering
//        stackForButtons.spacing = 1
//        stackForButtons = UIStackView(arrangedSubviews: arrButtonsLiteral)
//        viewForSortLiteral.backgroundColor = UIColor.red
//        viewForSortLiteral.addSubview(stackForButtons)
  
    
    @IBAction func reloadScreen(_ sender: Any) {
        self.tableView.reloadData()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destenationView = storyboard.instantiateViewController(withIdentifier: "TestFriendsTableViewController")
        
        self.navigationController?.pushViewController(destenationView, animated: true)
        
    }
    
}

