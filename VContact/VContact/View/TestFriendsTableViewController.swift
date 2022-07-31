//
//  TestFriendsTableViewController.swift
//  VContact
//
//  Created by Wally on 28.07.2022.
//

import UIKit
import Alamofire

class TestFriendsTableViewController: UITableViewController {
    let service = VKService()
    var friends: [FriendsNew]? {
        didSet {
           
            getAvatar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellTypeNib = UINib.init(nibName: "PhotoNameCell", bundle: nil)
        self.tableView.register(cellTypeNib, forCellReuseIdentifier: "PhotoNameType")
        
        
        DispatchQueue.global().async {
            let url = self.service.getURL(requestMethod: .friends)
            Alamofire.request(url).responseJSON { response in
                guard let data = response.data else { return }
                do {
                let jSon = try JSONDecoder().decode(ResponseFriendNew.self, from: data)
                let tmpFriends = jSon.response.items
                self.friends = tmpFriends
               
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getAvatar() {
       
        guard let friends = self.friends else { return }
        for friend in friends {
            DispatchQueue.global().async {
                if let url = URL(string: friend.photoURL),
                   let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        friend.avatar.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.friends?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNameType", for: indexPath) as! PhotoNameCell
        guard let friends = friends else { return cell }
            cell.first_name.text = friends[indexPath.row].name
            cell.last_name.text = friends[indexPath.row].familyName
            cell.avatar.image = friends[indexPath.row].avatar.image

        return cell
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
