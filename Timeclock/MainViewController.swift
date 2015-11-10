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

    @IBOutlet weak var inButton: UIButton!
    @IBOutlet weak var outButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showClockedIn(sender: UIButton) {
        userTableViewController.filter(filter: UserTableViewController.Filter.ClockedIn)
    }
    
    @IBAction func showClockedOut(sender: UIButton) {
        userTableViewController.filter(filter: UserTableViewController.Filter.ClockedOut)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userTableViewController = segue.destinationViewController as? UserTableViewController where segue.identifier == "Embed" {
            self.userTableViewController = userTableViewController
        }
    }

}

