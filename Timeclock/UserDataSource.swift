//
//  UserDataSource.swift
//  Example
//
//  Created by Aaron Wright on 11/7/15.
//  Copyright © 2015 Aaron Wright. All rights reserved.
//

import Foundation
import Alamofire

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
        
        let headers = [
            "Authorization": "Basic eDplYTNkMjQ3MGU2NWIwMTMwZjU0OTNlMWVkYmZmNDQ3ZQ=="
        ]
        
        Alamofire.request(.GET, "http://gameroom.swapzapp.com/api/users", headers: headers, parameters: ["clocked_in": true, "per_page": 0]).responseJSON { response in
            if let JSON = response.result.value {
                
                let users = (JSON.valueForKey("users") as! [NSDictionary]).filter({
                    ($0["active"] as! Bool) == true
                }).map {
                    User(firstName: $0["first_name"] as! String, lastName: $0["last_name"] as! String, email: $0["email"] as! String, username: $0["username"] as! String)
                }

                self.usersClockedIn = users
                
                if let delegate = self.delegate {
                    delegate.userDataSourceDidReloadData()
                }
            }
        }
        
        Alamofire.request(.GET, "http://gameroom.swapzapp.com/api/users", headers: headers, parameters: ["clocked_out": true, "per_page": 0]).responseJSON { response in
            if let JSON = response.result.value {
                
                let users = (JSON.valueForKey("users") as! [NSDictionary]).filter({
                    ($0["active"] as! Bool) == true
                }).map {
                    User(firstName: $0["first_name"] as! String, lastName: $0["last_name"] as! String, email: $0["email"] as! String, username: $0["username"] as! String)
                }

                self.usersClockedOut = users
                
                if let delegate = self.delegate {
                    delegate.userDataSourceDidReloadData()
                }
            }
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