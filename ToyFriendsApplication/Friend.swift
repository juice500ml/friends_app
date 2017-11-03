//
//  Friend.swift
//  ToyFriendsApplication
//
//  Created by sgcs on 2017. 11. 2..
//  Copyright © 2017년 Kwanghee Choi. All rights reserved.
//

import UIKit

class Friend {
    var photo: UIImage
    var titleName: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var nation: String
    var isBest: Bool
    
    init?(photoURL: String,
          titleName: String,
          firstName: String,
          lastName: String,
          email: String,
          phone: String,
          nation: String,
          isBest: Bool) {
        do {
            let url = URL(string: photoURL)
            let data = try Data(contentsOf: url!)
            self.photo = UIImage(data: data)!
        } catch {
            return nil
        }
        if titleName.isEmpty
            || firstName.isEmpty
            || lastName.isEmpty
            || email.isEmpty
            || phone.isEmpty
            || nation.isEmpty {
            return nil
        }
        self.titleName = String(titleName.first!).uppercased() + titleName.dropFirst()
        if titleName == "mr" {
            self.titleName = "Mr."
        }
        else if titleName == "miss" || titleName == "ms" {
            self.titleName = "Ms."
        }
        else if titleName == "mrs" {
            self.titleName = "Mrs."
        }
        self.firstName = String(firstName.first!).uppercased() + firstName.dropFirst()
        self.lastName = String(lastName.first!).uppercased() + lastName.dropFirst()
        self.email = email
        self.phone = phone
        self.nation = nation
        self.isBest = isBest
    }
    
    init(photo: UIImage,
         titleName: String,
         firstName: String,
         lastName: String,
         email: String,
         phone: String,
         nation: String,
         isBest: Bool) {
        self.photo = photo
        self.titleName = titleName
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.nation = nation
        self.isBest = isBest
    }
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.email == rhs.email
    }
}
