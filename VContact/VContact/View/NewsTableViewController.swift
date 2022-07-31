//
//  NewsTableViewController.swift
//  VContact
//
//  Created by Wally on 23.05.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var allNewsArr = [News(avatarPhoto: UIImage(named: "Chapoklyak")!, nameUser: "Chapoklyak", dateNews: "23.05.2022", textNews: "Chinese rover finds new evidence of water on Mars.", imageNews: UIImage(named: "Chapoklyak23.05.2022")!, likeImage: UIImage(systemName: "heart")!, countLike: 0)]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCellType")
    
        let session = VKService()
        session.getNewsfeed(complation: ){ response in
            for element in response {
                let news = News(avatarPhoto: UIImage(named: "Chapoklyak")!, nameUser: "Chapoklyak", dateNews: String(element.date), textNews: element.text, imageNews: UIImage(named: "Chapoklyak")!, likeImage: UIImage(systemName: "heart")!, countLike: 0)
                self.allNewsArr.append(news)
            }
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            print(self.allNewsArr.count)
            self.tableView.reloadData()
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allNewsArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellType", for: indexPath) as! NewsTableViewCell
        cell.avatarPhoto.image = allNewsArr[indexPath.row].avatarPhoto
        cell.nameUser.text = allNewsArr[indexPath.row].nameUser
        cell.dateNews.text = allNewsArr[indexPath.row].dateNews
        cell.textNews.text = allNewsArr[indexPath.row].textNews
        cell.imageNews.image = allNewsArr[indexPath.row].imageNews
        self.view.layoutIfNeeded()
        cell.likeImage.image = allNewsArr[indexPath.row].likeImage
        cell.countLike.text = String(allNewsArr[indexPath.row].countLike)
        
        
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
