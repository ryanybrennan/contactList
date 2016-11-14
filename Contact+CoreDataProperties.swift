//
//  Contact+CoreDataProperties.swift
//  Contact_list
//
//  Created by Ryan Brennan on 10/3/16.
//  Copyright © 2016 Ryan Brennan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var number: String?

}
