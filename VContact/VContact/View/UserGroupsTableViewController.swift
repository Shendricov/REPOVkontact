//
//  GroupsTableViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 10.05.2022.
//

import UIKit
import Alamofire
import RealmSwift

protocol chengeUserGroups {
    func chengeUserGroups()
}

class UserGroupsTableViewController: UITableViewController {

    var allGroups: Results<Group>!
    
    
//    var userGroups: Array<Group> = []
    private var groupsToken: NotificationToken?
  
    var groupsResults: Results<Groups>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        loadData()
        
        let session = VKService()
        session.getCollectionGroups()
      
        let cellNibType = UINib(nibName: "PhotoNameCell", bundle: nil)
        tableView.register(cellNibType, forCellReuseIdentifier: "PhotoNameType")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        updateUserGroups(groups: userGroups)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getUserGroups()
    }
    
//    private func updateUserGroups(groups: [Group]){
//        userGroups = groups
//    }
    // MARK: - Table view data source

    private func loadData() {
        do {
            let realm = try Realm()
            allGroups = realm.objects(Group.self)
            print(allGroups ?? "ОШИБКА")
            groupsToken = allGroups.observe({change in
                switch change {
                    
                case .initial(_):
                    self.tableView.reloadData()
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.insertRows(at: insertions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    print(error.localizedDescription)
                }
                
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroups.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNameType", for: indexPath) as! PhotoNameCell
        cell.first_name.text = allGroups[indexPath.row].title
        cell.last_name.text = ""
        cell.avatar.image = UIImage(imageLiteralResourceName: "Groups/Formula1")

        return cell
    }
  
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let conAction = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            var index: Int = 0
            self.allGroups.forEach({group in
                if group == self.allGroups[indexPath.row]{
                    self.allGroups[index].selected = false
                   }
                index += 1
            })
//            self.getUserGroups()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        })
        let action = UISwipeActionsConfiguration(actions: [conAction])
        return action
    }

    @IBAction func chooseGroup(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destenationView = storyboard.instantiateViewController(withIdentifier: "AllGroupsTableViewController") as! AllGroupsTableViewController
        destenationView.allGroupsChoose = allGroups
//        destenationView.updeteUserGroup = {[self] group in
//            allGroups = group
//            getUserGroups()
//            tableView.reloadData()
//        }
        self.navigationController?.pushViewController(destenationView, animated: true)
    }
    
//    func getUserGroups() {
//        allGroups.
//        allGroups.forEach({group in
//            if group.selected, !userGroups.contains(group){
//                userGroups.append(group)
//            }
//        })
//    }
    
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

}
