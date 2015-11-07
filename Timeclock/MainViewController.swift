//
//  MainViewController.swift
//  Example
//
//  Created by Aaron Wright on 11/7/15.
//  Copyright © 2015 Aaron Wright. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var userTableViewController: UserTableViewController!

    @IBOutlet weak var filterControl: UISegmentedControl!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func filterChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            userTableViewController.filter(filter: UserTableViewController.Filter.ClockedIn)
        case 1:
            userTableViewController.filter(filter: UserTableViewController.Filter.ClockedOut)
        default:
            userTableViewController.filter(filter: UserTableViewController.Filter.ClockedIn)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userTableViewController = segue.destinationViewController as? UserTableViewController where segue.identifier == "Embed" {
            self.userTableViewController = userTableViewController
        }
    }

}

