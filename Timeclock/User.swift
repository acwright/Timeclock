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
    var lastIn: NSDate?
    var lastOut: NSDate?
    
    var fullName: String {
        get {
            return "\(self.firstName) \(self.lastName)"
        }
    }
    
    init(firstName: String, lastName: String, email: String, username: String, lastIn: String, lastOut: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        self.lastIn = formatter.dateFromString(lastIn)
        self.lastOut = formatter.dateFromString(lastOut)
    }
}