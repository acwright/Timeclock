//
//  UserTableViewController.swift
//  Example
//
//  Created by Aaron Wright on 11/7/15.
//  Copyright © 2015 Aaron Wright. All rights reserved.
//

import UIKit

protocol UserTableViewControllerDelegate {
    func userTableViewDidBeginReloadingData()
    func userTableViewDidFinishReloadingData()
}

class UserTableViewController: UITableViewController, UserDataSourceDelegate {
    
    enum Filter {
        case ClockedIn
        case ClockedOut
    }
    
    let userDataSource: UserDataSource = UserDataSource()
    
    var delegate: UserTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDataSource.delegate = self
        self.filter(filter: Filter.ClockedIn)
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
    
    func userDataSourceDidBeginReloadingData() {
        if let delegate = self.delegate {
            delegate.userTableViewDidBeginReloadingData()
        }
    }
    
    func userDataSourceDidFinishReloadingInData() {
        switch self.userDataSource.filter {
        case UserDataSource.Filter.ClockedIn:
            self.tableView.reloadData()
        case UserDataSource.Filter.ClockedOut:
            break
        }
        
        if let delegate = self.delegate {
            delegate.userTableViewDidFinishReloadingData()
        }
    }
    
    func userDataSourceDidFinishReloadingOutData() {
        switch self.userDataSource.filter {
        case UserDataSource.Filter.ClockedIn:
            break
        case UserDataSource.Filter.ClockedOut:
            self.tableView.reloadData()
        }
        
        if let delegate = self.delegate {
            delegate.userTableViewDidFinishReloadingData()
        }
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
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        formatter.timeStyle = NSDateFormatterStyle.FullStyle
        
        switch self.userDataSource.filter {
        case UserDataSource.Filter.ClockedIn:
            if let lastIn = user.lastIn {
                cell.detailTextLabel?.text = formatter.stringFromDate(lastIn)
            }
        case UserDataSource.Filter.ClockedOut:
            if let lastOut = user.lastOut {
                cell.detailTextLabel?.text = formatter.stringFromDate(lastOut)
            }
        }
    
        return cell
    }
    
}
