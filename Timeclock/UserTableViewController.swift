//
//  UserTableViewController.swift
//  Example
//
//  Created by Aaron Wright on 11/7/15.
//  Copyright © 2015 Aaron Wright. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController, UserDataSourceDelegate {
    
    enum Filter {
        case ClockedIn
        case ClockedOut
    }
    
    let userDataSource: UserDataSource = UserDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDataSource.delegate = self
    }
    
    func filter(filter filter: Filter) {
        switch filter {
        case Filter.ClockedIn:
            self.userDataSource.filter = UserDataSource.Filter.ClockedIn
        case Filter.ClockedOut:
            self.userDataSource.filter = UserDataSource.Filter.ClockedOut
        }
    }
    
    // MARK; - UserDataSourceDelegate
    
    func userDataSourceDidReloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataSource.count()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath)
        let users = self.userDataSource.users()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.fullName
        cell.detailTextLabel?.text = user.username
    
        return cell
    }
    
}
