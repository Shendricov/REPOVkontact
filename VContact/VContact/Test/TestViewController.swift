//
//  TestViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 06.05.2022.
//

import UIKit

class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var familyName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        name.text = "Mikhail"
//        familyName.text = "Shendrikov"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        configureCell(cell: &cell)
        
        return cell
    }
    
    private func configureCell(cell: inout UITableViewCell) {
        var configure = cell.defaultContentConfiguration()
        configure.text = "Shendrikov Mikhail"
        configure.secondaryText = "Mikhail"
        cell.contentConfiguration = configure
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextActionOne = UIContextualAction(style: .destructive, title: "Yahoo", handler: { _,_,_ in
            print("swipe")
        })
        let contextActionTwo = UIContextualAction(style: .destructive, title: "Google", handler: { _,_,_ in
            print("swipe")
        })
        let action = UISwipeActionsConfiguration(actions: [contextActionOne, contextActionTwo])
        return action
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


