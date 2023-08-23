//
//  TSCoreDataManager.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import CoreData
import UIKit

open class TSCoreDataManager: NSObject {
    
    static let sharedInstance = TSCoreDataManager()
    override fileprivate init() {}
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "TechSaga", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true,NSInferMappingModelAutomaticallyOption: true,NSPersistentStoreFileProtectionKey:false])
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "TechSaga", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
#if DEBUG
            abort()
#else
#endif
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.overwriteMergePolicyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.overwriteMergePolicyType)
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let moc = managedObjectContext
        moc.performAndWait {
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch _ {
                }
            }
        }
    }
    
    func deleteObject ( _ object : NSManagedObject ) {
        managedObjectContext.performAndWait {
            managedObjectContext.delete(object)
        }
    }
    
    func insertNewObjectInContext(_ entityName: String) -> NSManagedObject? {
        var output: NSManagedObject?
        managedObjectContext.performAndWait{
            do {
                let objects = NSEntityDescription.insertNewObject(forEntityName: entityName, into: self.managedObjectContext)
                output = objects
            }
        }
        return output
    }
    
    func fetchDataForEntity(_ entity:String, predicate:NSPredicate? = nil, sortWith:NSArray? = nil, onMainQueue : Bool = true) -> [NSManagedObject]? {
        let moc = managedObjectContext
        var output:[NSManagedObject]?
        moc.performAndWait {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                request.entity = NSEntityDescription.entity(forEntityName: entity as String, in: moc)
                request.predicate = predicate
                if let sortDescriptors = sortWith as? [NSSortDescriptor] {
                    request.sortDescriptors = sortDescriptors
                }
                let objects = try moc.fetch(request) as? [NSManagedObject]
                output = objects
            } catch _ {
            }
        }
        return output
    }
}

extension NSManagedObject {
    
    class func entityName() -> String {
        let fullClassName: String = NSStringFromClass(object_getClass(self)!)
        var last = fullClassName.split {$0 == "."}.map(String.init)
        last = last.last!.split {$0 == " "}.map(String.init)
        last = last.last!.split {$0 == "_"}.map(String.init)
        return last.last!
    }
    
    class func insertNewObject() -> NSManagedObject? {
        return TSCoreDataManager.sharedInstance.insertNewObjectInContext(entityName())
    }
    
    class func getAllObjects() -> [NSManagedObject]? {
        return TSCoreDataManager.sharedInstance.fetchDataForEntity(entityName())
    }
    
    class func saveRecords() {
        DispatchQueue.main.async {
            print(entityName())
            TSCoreDataManager.sharedInstance.saveContext()
        }
    }
    
    class func deleteObjects(_ objects:[NSManagedObject]) {
        for obj in objects {
            TSCoreDataManager.sharedInstance.deleteObject(obj)
        }
    }
    
    class func getObjectPredicate(_ predicate: NSPredicate? = nil , sort : [NSSortDescriptor]? = nil, onMainQueue : Bool = true) -> [NSManagedObject]? {
        let list = TSCoreDataManager.sharedInstance.fetchDataForEntity(entityName(), predicate: predicate, sortWith: sort as NSArray?, onMainQueue : onMainQueue)
        return list
    }
}

