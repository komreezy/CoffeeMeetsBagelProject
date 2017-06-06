//
//  Employee.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/3/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

struct Employee {
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var title: String = ""
    var avatar: String = ""
    var bio: String = ""
    
    func toDict() -> [String : String] {
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "title": title,
            "avatar": avatar,
            "bio": bio
        ]
    }
}

extension Employee {
    init(_ dictionary: JSON) {
        if let id = dictionary["id"] {
            self.id = id
        }
        
        if let firstName = dictionary["firstName"] {
            self.firstName = firstName
        }
        
        if let lastName = dictionary["lastName"] {
            self.lastName = lastName
        }
        
        if let title = dictionary["title"] {
            self.title = title
        }
        
        if let avatar = dictionary["avatar"] {
            self.avatar = avatar
        }
        
        if let bio = dictionary["bio"] {
            self.bio = bio
        }
    }
}
