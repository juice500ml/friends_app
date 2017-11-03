//
//  BestFriendsViewController.swift
//  ToyFriendsApplication
//
//  Created by sgcs on 2017. 11. 3..
//  Copyright © 2017년 Kwanghee Choi. All rights reserved.
//

import UIKit

class BestFriendsViewController: UITableViewController {
    var friends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 90.0
        self.navigationItem.rightBarButtonItem = editButtonItem

        let db = FriendsStorageController()
        self.friends = db.getAll()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let db = FriendsStorageController()
        self.friends = db.getAll()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        if indexPath.row < self.friends.count {
            let friend = friends[indexPath.row]
            cell.nameLabel.text = friend.titleName + " " + friend.firstName + " " + friend.lastName
            cell.emailLabel.text = friend.email
            cell.photoImageView.image = friend.photo
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let index = tableView.indexPath(for: cell)
        if let indexPath = index?.row {
            let newView = segue.destination as! DetailViewController
            newView.friend = self.friends[indexPath]
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt from: IndexPath, to: IndexPath) {
        let itemToMove = self.friends[from.row]
        self.friends.remove(at: from.row)
        self.friends.insert(itemToMove, at: to.row)
        let db = FriendsStorageController()
        db.purge()
        for friend in self.friends {
            db.add(friend: friend)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let db = FriendsStorageController()
            db.remove(friend: self.friends[indexPath.row])
            self.friends.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
