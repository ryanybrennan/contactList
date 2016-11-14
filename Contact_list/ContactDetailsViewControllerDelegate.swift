//
//  ContactDetailsViewControllerDelegate.swift
//  Contact_list
//
//  Created by Ryan Brennan on 10/3/16.
//  Copyright © 2016 Ryan Brennan. All rights reserved.
//

import Foundation; import UIKit
protocol ContactDetailsViewControllerDelegate: class{
    func contactDetailsViewController(controller: ContactDetailsViewController, didFinishAddingFirstName fname: String, didFinishAddingLastName lname: String, didFinishAddingNumber number: String)
    func contactDetailsViewController(controller: ContactDetailsViewController, didFinishEditingFirstName fname: [Contact], didFinishEditingLastName lname: [Contact], didFinishEditingNumber number: [Contact])
}
