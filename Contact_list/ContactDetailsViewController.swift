//
//  ContactDetailsViewController.swift
//  Contact_list
//
//  Created by Ryan Brennan on 10/3/16.
//  Copyright © 2016 Ryan Brennan. All rights reserved.
//

import Foundation; import UIKit
class ContactDetailsViewController: UIViewController{
    var contactToEdit: Contact?
    var contactToEditIndexPath: Int?
    
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: ContactDetailsViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (contactToEdit != nil){
            self.title = "Edit Contact"
            numberText.text = contactToEdit?.number
            lastNameText.text = contactToEdit?.lastName
            firstNameText.text = contactToEdit?.firstName
        }else{
            self.title = "New Contact"
        }
    }
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    @IBAction func saveBarButtonPressed(sender: UIBarButtonItem) {
        if let contact = contactToEdit{
            contact.firstName = firstNameText.text!
            contact.lastName = lastNameText.text!
            contact.number = numberText.text!
            delegate?.contactDetailsViewController(self, didFinishEditingFirstName: [contact], didFinishEditingLastName: [contact], didFinishEditingNumber: [contact])
        }else{
            let fname = firstNameText.text!
            let lname = lastNameText.text!
            let number = numberText.text!
            delegate?.contactDetailsViewController(self, didFinishAddingFirstName: fname, didFinishAddingLastName: lname, didFinishAddingNumber: number)
        }
    }
    
}
