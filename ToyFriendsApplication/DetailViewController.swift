//
//  DetailViewController.swift
//  ToyFriendsApplication
//
//  Created by sgcs on 2017. 11. 3..
//  Copyright © 2017년 Kwanghee Choi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nationLabel: UILabel!
    @IBOutlet weak var webButton: UIButton!
    
    var friend: Friend? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.photoImageView.image = self.friend?.photo
        self.nameLabel.text = (self.friend?.titleName)! + " " + (self.friend?.firstName)! + " " + (self.friend?.lastName)!
        self.title = (self.friend?.titleName)! + " " + (self.friend?.lastName)!
        self.emailLabel.text = self.friend?.email
        self.phoneLabel.text = self.friend?.phone
        self.nationLabel.text = self.friend?.nation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
