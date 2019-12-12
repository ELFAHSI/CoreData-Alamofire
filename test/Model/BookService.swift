//
//  AppDelegate.swift
//  test
//  Copyright © 2019 BENNOUR EL FAHSI. All rights reserved.
//

import Foundation
import CoreData

class Service {
    
    internal static func getData(managedObjectContext:NSManagedObjectContext) -> NSFetchedResultsController<Book> {
        let fetchedResultController: NSFetchedResultsController<Book>
        
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultController.performFetch()
        }
        catch {
            fatalError("Error in fetching records")
        }
        
        return fetchedResultController
    }
}
