//
//  AllGroupsTableViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 11.05.2022.
//

import UIKit
import RealmSwift
class AllGroupsTableViewController: UITableViewController {

    var allGroupsChoose: Results<Group>!
    var userGroupsChoose: Results<Group>!
    private var filteredSearchGroups: Array<Group> = []

    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibTypeCell = UINib(nibName: "PhotoNameCell", bundle: nil)
        tableView.register(nibTypeCell, forCellReuseIdentifier: "PhotoNameType")
        
//  результат поиска будет получать текущий класс.
        searchController.searchResultsUpdater = self
//  позволит взаимодействовать с элементами, полученными в результате поиска.
        searchController.obscuresBackgroundDuringPresentation = false
//  надпись на незаполненном полу.
        searchController.searchBar.placeholder = "Search"
//  добавляем созданный нами поиск в navigation bar в раздел search.
        navigationItem.searchController = searchController
//  опускаем строку поиска при переходе на другой экран.
        definesPresentationContext = true
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
          return filteredSearchGroups.count
        }
        
        return allGroupsChoose.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNameType", for: indexPath) as! PhotoNameCell
        
        var currentGroup: Group!
        if isFiltering {
            currentGroup = filteredSearchGroups[indexPath.row]
        } else {
            currentGroup = allGroupsChoose[indexPath.row]
        }
        
        cell.first_name.text = currentGroup.title
        cell.avatar.image = UIImage(imageLiteralResourceName: "Groups/Formula1")
        if currentGroup.selected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            var filteredGroup = filteredSearchGroups[indexPath.row]
            if filteredGroup.selected {
                filteredGroup.selected = false
                filteredSearchGroups[indexPath.row] = filteredGroup
            } else {
                filteredGroup.selected = true
                filteredSearchGroups[indexPath.row] = filteredGroup
            }
//            var index = 0
//            allGroupsChoose.forEach({(group: Group) in
//                if group.title == filteredGroup.title {
//                    (Array(allGroupsChoose))[index] = filteredGroup
//                }
//                index += 1
//            })
        } else {
            if allGroupsChoose[indexPath.row].selected {
                allGroupsChoose[indexPath.row].selected = false
            } else {
                allGroupsChoose[indexPath.row].selected = true
            }
        }
        tableView.reloadData()
    }
    
    var updeteUserGroup:(([Group]) -> Void)?
    @IBAction func backToUserGroups(_ sender: UIBarButtonItem) {
        navigationController?.viewControllers.forEach({controller in
            (controller as? UserGroupsTableViewController)?.allGroups = allGroupsChoose})
//        updeteUserGroup?(allGroupsChoose)
        navigationController?.popViewController(animated: true)
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

}

extension AllGroupsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        getArrayForFilteredSearchGroups(searchController.searchBar.text!)
    }
    
    private func getArrayForFilteredSearchGroups(_ searchText: String) {
        
        filteredSearchGroups = allGroupsChoose.filter({ (group: Group) -> Bool in
            group.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
}
