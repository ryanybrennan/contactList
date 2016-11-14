//
//  ViewContactViewController.swift
//  Contact_list
//
//  Created by Ryan Brennan on 10/3/16.
//  Copyright © 2016 Ryan Brennan. All rights reserved.
//

import Foundation; import UIKit
class ViewContactViewController: UIViewController{
    var contactToView: Contact?
    var contactToViewIndexPath: Int?
    weak var doneButtonDelegate: CancelButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = contactToView?.firstName
        nameLabel.text = (contactToView?.firstName)! + " " + (contactToView?.lastName)!
        numberLabel.text = contactToView?.number
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        doneButtonDelegate?.cancelButtonPressedFrom(self)
    }
}
