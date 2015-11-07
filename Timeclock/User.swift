//
//  User.swift
//  Example
//
//  Created by Aaron Wright on 11/7/15.
//  Copyright © 2015 Aaron Wright. All rights reserved.
//

import Foundation

class User {
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    
    var fullName: String {
        get {
            return "\(self.firstName) \(self.lastName)"
        }
    }
    
    init(firstName: String, lastName: String, email: String, username: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
    }
}