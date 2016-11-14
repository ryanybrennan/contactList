//
//  ViewController.swift
//  Contact_list
//
//  Created by Ryan Brennan on 10/3/16.
//  Copyright © 2016 Ryan Brennan. All rights reserved.
//

import UIKit; import CoreData

class ContactListViewController: UITableViewController, CancelButtonDelegate, ContactDetailsViewControllerDelegate {
    var contacts = [Contact]()
    var operant = 1
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchAllContacts(){
        let userRequest = NSFetchRequest(entityName: "Contact")
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            contacts = results as! [Contact]
        } catch {
            print("\(error)")
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") as! CustomContactCell
        cell.nameLabel!.text = contacts[indexPath.row].firstName! + " " + contacts[indexPath.row].lastName!
        cell.numberLabel!.text = contacts[indexPath.row].number
        return cell
    }

    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        operant = 0
        performSegueWithIdentifier("ContactDetails", sender: self)
    }
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select", message: "What would you like to do?", preferredStyle: .ActionSheet)
        let viewAction: UIAlertAction = UIAlertAction(title: "View", style: .Default){action -> Void in
            self.operant = 2
            self.performSegueWithIdentifier("ViewContact", sender: tableView.cellForRowAtIndexPath(indexPath))
        }
        let editAction: UIAlertAction = UIAlertAction(title: "Edit", style: .Default){action -> Void in
            self.operant = 1
            self.performSegueWithIdentifier("ContactDetails", sender: tableView.cellForRowAtIndexPath(indexPath))
        }
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .Destructive){action -> Void in
                let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                context.deleteObject(self.contacts[indexPath.row])
                self.contacts.removeAtIndex(indexPath.row)
                if context.hasChanges {
                    do {
                        try context.save()
                        print("Success")
                    } catch {
                        print("\(error)")
                    }
                }
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.fetchAllContacts()
                tableView.reloadData()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel){action -> Void in
        }
        actionSheetController.addAction(viewAction)
        actionSheetController.addAction(editAction)
        actionSheetController.addAction(deleteAction)
        actionSheetController.addAction(cancelAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if operant == 2{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ViewContactViewController
            controller.doneButtonDelegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                controller.contactToView = contacts[indexPath.row]
                controller.contactToViewIndexPath = indexPath.row
            }
        }
        if operant == 0{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ContactDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
        if operant == 1{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ContactDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                controller.contactToEdit = contacts[indexPath.row]
                controller.contactToEditIndexPath = indexPath.row
            }

        }
    }
    func contactDetailsViewController(controller: ContactDetailsViewController, didFinishAddingFirstName fname: String, didFinishAddingLastName lname: String, didFinishAddingNumber number: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let add = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: managedObjectContext) as! Contact
        add.firstName = fname
        add.lastName = lname
        add.number = number
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllContacts()
        tableView.reloadData()
    }
    func contactDetailsViewController(controller: ContactDetailsViewController, didFinishEditingFirstName fname: [Contact], didFinishEditingLastName lname: [Contact], didFinishEditingNumber number: [Contact]) {
        dismissViewControllerAnimated(true, completion: nil)
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllContacts()
        tableView.reloadData()
    }
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context:NSManagedObjectContext = appDel.managedObjectContext
//        context.deleteObject(contacts[indexPath.row])
//        contacts.removeAtIndex(indexPath.row)
//        if context.hasChanges {
//            do {
//                try context.save()
//                print("Success")
//            } catch {
//                print("\(error)")
//            }
//        }
//        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        fetchAllContacts()
//        tableView.reloadData()
//    }

}

