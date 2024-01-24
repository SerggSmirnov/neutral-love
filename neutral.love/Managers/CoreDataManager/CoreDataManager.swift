//
//  CoreDataManager.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 16.12.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Save viewContext failed \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Save Image
    
    func saveImage(caption: String, full: Data?, preview: Data?) {
        if isThereNoImageInDB(caption: caption) {
            let generateImage = GenerateImage(context: viewContext)
            
                generateImage.caption = caption
                generateImage.full = full
                generateImage.preview = preview
                saveContext()
        }
    }
    
    // MARK: - Create Fetched Results Controller
    
    func createPreparedFetchedResultsController() -> NSFetchedResultsController<GenerateImage> {
        
        let imageFetchRequest = GenerateImage.fetchRequest()
        imageFetchRequest.sortDescriptors = []
        
        let resultController = NSFetchedResultsController(
            fetchRequest: imageFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        return resultController
    }
    
    // MARK: - Find dublicate in DB
    
    private func isThereNoImageInDB(caption: String) -> Bool {
        var result: [GenerateImage] = []
        let imageFetchRequest = GenerateImage.fetchRequest()
        imageFetchRequest.predicate = NSPredicate(format: "%K == %@",
                                                  #keyPath(GenerateImage.caption),
                                                  caption)
        do {
            result = try viewContext.fetch(imageFetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return result.isEmpty
    }
}
