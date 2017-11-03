//
//  FriendsStorageController.swift
//  ToyFriendsApplication
//
//  Created by sgcs on 2017. 11. 3..
//  Copyright © 2017년 Kwanghee Choi. All rights reserved.
//

import UIKit
import CoreData

class FriendsStorageController {
    var container: NSPersistentContainer
    var tableRequest: NSFetchRequest<NSFetchRequestResult>

    init() {
        self.tableRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendModel")
        self.container = NSPersistentContainer(name: "FriendsStorage")
        self.container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        })
    }
    
    func getAll()->[Friend] {
        var friends = [Friend]()
        do {
            let result = try self.container.viewContext.fetch(self.tableRequest)
            for data in result as! [NSManagedObject] {
                friends.append(Friend(
                    photo: UIImage(data: (data.value(forKey: "photo") as! NSData) as Data)!,
                    titleName: data.value(forKey: "titleName") as! String,
                    firstName: data.value(forKey: "firstName") as! String,
                    lastName: data.value(forKey: "lastName") as! String,
                    email: data.value(forKey: "email") as! String,
                    phone: data.value(forKey: "phone") as! String,
                    nation: data.value(forKey: "nation") as! String,
                    isBest: true
                ))
            }
        } catch {}
        return friends
    }
    
    func remove(friend: Friend) {
        do {
            friend.isBest = true
            let result = try self.container.viewContext.fetch(self.tableRequest)
            for data in result as! [NSManagedObject] {
                let row = Friend(
                    photo: UIImage(data: (data.value(forKey: "photo") as! NSData) as Data)!,
                    titleName: data.value(forKey: "titleName") as! String,
                    firstName: data.value(forKey: "firstName") as! String,
                    lastName: data.value(forKey: "lastName") as! String,
                    email: data.value(forKey: "email") as! String,
                    phone: data.value(forKey: "phone") as! String,
                    nation: data.value(forKey: "nation") as! String,
                    isBest: true
                )
                if row == friend {
                    self.container.viewContext.delete(data)
                    break
                }
            }
            try self.container.viewContext.save()
        } catch { }
    }
    
    func find(friend: Friend)->Bool {
        do {
            friend.isBest = true
            let result = try self.container.viewContext.fetch(self.tableRequest)
            for data in result as! [NSManagedObject] {
                let row = Friend(
                    photo: UIImage(data: (data.value(forKey: "photo") as! NSData) as Data)!,
                    titleName: data.value(forKey: "titleName") as! String,
                    firstName: data.value(forKey: "firstName") as! String,
                    lastName: data.value(forKey: "lastName") as! String,
                    email: data.value(forKey: "email") as! String,
                    phone: data.value(forKey: "phone") as! String,
                    nation: data.value(forKey: "nation") as! String,
                    isBest: true
                )
                if row == friend {
                    return true
                }
            }
            try self.container.viewContext.save()
        } catch { }
        return false
    }
    
    func add(friend: Friend) {
        do {
            let result = try self.container.viewContext.fetch(self.tableRequest)
            for data in result as! [NSManagedObject] {
                let row = Friend(
                    photo: UIImage(data: (data.value(forKey: "photo") as! NSData) as Data)!,
                    titleName: data.value(forKey: "titleName") as! String,
                    firstName: data.value(forKey: "firstName") as! String,
                    lastName: data.value(forKey: "lastName") as! String,
                    email: data.value(forKey: "email") as! String,
                    phone: data.value(forKey: "phone") as! String,
                    nation: data.value(forKey: "nation") as! String,
                    isBest: true
                )
                if row == friend {
                    return
                }
            }
            let entity = NSEntityDescription.entity(forEntityName: "FriendModel", in: self.container.viewContext)
            let row = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
            row.setValue(UIImagePNGRepresentation(friend.photo) as NSData?, forKey: "photo")
            row.setValue(friend.titleName, forKey:"titleName")
            row.setValue(friend.firstName, forKey:"firstName")
            row.setValue(friend.lastName, forKey:"lastName")
            row.setValue(friend.email, forKey:"email")
            row.setValue(friend.phone, forKey:"phone")
            row.setValue(friend.nation, forKey:"nation")
            try self.container.viewContext.save()
        } catch {
            print(">????")
        }
    }
    
    func purge() {
        do {
            let result = try self.container.viewContext.fetch(self.tableRequest)
            for data in result as! [NSManagedObject] {
                self.container.viewContext.delete(data)
            }
            try self.container.viewContext.save()
        } catch { }
    }
}
