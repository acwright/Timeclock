//
//  UserDataSource.swift
//  Example
//
//  Created by Aaron Wright on 11/7/15.
//  Copyright © 2015 Aaron Wright. All rights reserved.
//

import Foundation

protocol UserDataSourceDelegate {
    func userDataSourceDidReloadData()
}

class UserDataSource {
    
    enum Filter {
        case ClockedIn
        case ClockedOut
    }
    
    var filter: Filter = Filter.ClockedIn {
        didSet {
            self.loadData()
        }
    }
    
    var delegate: UserDataSourceDelegate?
    
    private var usersClockedIn: [User] = []
    private var usersClockedOut: [User] = []
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        self.usersClockedIn = []
        self.usersClockedOut = []
        
        let user1 = User(firstName: "Aaron", lastName: "Wright", email: "acwrightdesign@gmail.com", username: "acwrightdesign")
        let user2 = User(firstName: "Joe", lastName: "Example", email: "example@example.com", username: "example")
        
        self.usersClockedIn = [user1, user2]
        
        if let delegate = self.delegate {
            delegate.userDataSourceDidReloadData()
        }
    }
    
    func count() -> Int {
        switch self.filter {
        case Filter.ClockedIn:
            return self.usersClockedIn.count
        case Filter.ClockedOut:
            return self.usersClockedOut.count
        }
    }
    
    func users() -> [User] {
        switch self.filter {
        case Filter.ClockedIn:
            return self.usersClockedIn
        case Filter.ClockedOut:
            return self.usersClockedOut
        }
    }
}