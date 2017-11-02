//
//  FrinedsViewController.swift
//  ToyFriendsApplication
//
//  Created by sgcs on 2017. 11. 2..
//  Copyright © 2017년 Kwanghee Choi. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    var friends: [Friend] = []
    var chosenFriend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.rowHeight = 90.0
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        self.refreshControl?.addTarget(self, action: #selector(FriendsViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.refreshControl?.beginRefreshing()
        self.refresh(Optional<Int>.none as Any)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func getFriends() {
        let url = URL(string: "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let results = jsonObj!.value(forKey:"results") as? NSArray {
                    for case let result as NSDictionary in results {
                        let name = result["name"] as! NSDictionary
                        let picture = result["picture"] as! NSDictionary
                        if let friend = Friend(
                            photoURL: picture["medium"] as! String,
                            titleName: name["title"] as! String,
                            firstName: name["first"] as! String,
                            lastName: name["last"] as! String,
                            email: result["email"] as! String,
                            phone: result["cell"] as! String,
                            nation: result["nat"] as! String,
                            isBest: false
                            ){
                            self.friends.append(friend)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                    self.refreshControl?.endRefreshing()
                }
            }
        }).resume()
    }
    
    @IBAction func refresh(_ sender: Any) {
        self.friends.removeAll()
        getFriends()
    }
}

