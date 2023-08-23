//
//  TSNewsEntity+CoreDataProperties.swift
//  
//
//  Created by Harshit Jain on 23/08/23.
//
//

import Foundation
import CoreData


extension TSNewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TSNewsEntity> {
        return NSFetchRequest<TSNewsEntity>(entityName: "TSNewsEntity")
    }

    @NSManaged public var data: Any?

}
