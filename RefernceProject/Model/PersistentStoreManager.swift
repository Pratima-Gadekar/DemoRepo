//
//  PersistentStoreManager.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import Foundation
import CoreData

final class PersistentStoreManager
{
    //Singleton logic
    static var managerHandle : PersistentStoreManager?
    
    class func createManager() -> PersistentStoreManager
    {
        if nil == managerHandle
        {
            managerHandle = PersistentStoreManager()
        }
        return managerHandle!
    }
    
    private init()
    {
        
    }
    
    //Types --------------------------------------------------
    typealias UIUpdaterClosure = ([Response]) -> Void
    
    //Functions --------------------------------------------------
    /**
     This function performs a background fetch
     - important: This function does not do validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    @available(iOS, introduced: 11.0, message: "background fetch function")
    func performBackgroundFetch(AndUpdateWith uiUpdater : @escaping UIUpdaterClosure)
    {
        //1) Get the connection to the DB
        let context : NSManagedObjectContext = persistentContainer.viewContext
        
        //2) Create the fetch request
        let fetchRequest : NSFetchRequest<Response> = Response.fetchRequest()
        
        //3) Sort descriptor
        let nameSort : NSSortDescriptor = NSSortDescriptor(key: "surveyDate", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        
        //4) Private context
        let privateContext : NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        privateContext.parent = context
        
        //5) Async fetch request
        let asyncFetchRequest : NSAsynchronousFetchRequest<Response> = NSAsynchronousFetchRequest(fetchRequest: fetchRequest, completionBlock: {(result : NSAsynchronousFetchResult<Response>) -> Void in
            
            print(result.finalResult!)
            guard let answer = result.finalResult
                else { return }
            DispatchQueue.main.async {
                uiUpdater(answer)
            }
        })
        
        //6) Perform the fetch in the background
        privateContext.perform({() -> Void in
            //execute fetch
            do
            {
                try privateContext.execute(asyncFetchRequest as NSPersistentStoreRequest)
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        })
    }
    
    /**
     This function performs a background insert
     - important: This function does not do validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    @available(iOS, introduced: 11.0, message: "background fetch function")
    func insertData(with information : SurveyModel)
    {
        //1) Get the connection to the DB
        let context : NSManagedObjectContext = persistentContainer.viewContext
        
        //2) Private context
        let privateContext : NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        privateContext.parent = context
        privateContext.mergePolicy = NSMergePolicy.overwrite
        
        //3) Perform write in the background
        privateContext.perform({() -> Void in
            
            //4) Prepare the scratch pad object
            let responseInfo : Response? = NSEntityDescription.insertNewObject(forEntityName: "Response", into: context) as? Response
            
            responseInfo?.name              = information.name
            responseInfo?.dob               = information.dateOfBirth
            responseInfo?.email             = information.email
            responseInfo?.cellPhone         = information.phone
            responseInfo?.surveyDate        = information.dateOfSurvey
            
            let ratingInfo : Rating?        = NSEntityDescription.insertNewObject(forEntityName: "Rating", into: context) as? Rating
            ratingInfo?.ambience            = information.ratings.ambienceRating.toInt()
            ratingInfo?.food                = information.ratings.foodRating.toInt()
            ratingInfo?.service             = information.ratings.serviceRating.toInt()
            responseInfo?.ratings           = ratingInfo
            
            //5) Perform save
            do
            {
                try privateContext.save()
                do
                {
                    try context.save()
                }
                catch let error
                {
                    print(error.localizedDescription)
                }
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        })
    }
    
    /**
     This function performs a background delete
     - important: This function does not do validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    func asyncDelete(nameToDelete : String)
    {
        //1) Get the private connection
        let privateContext  = persistentContainer.newBackgroundContext()
        
        //2) Fetch request
        let fetchRequest : NSFetchRequest<Response> = Response.fetchRequest()
        
        //3) Async fetch
        let asyncFetch = NSAsynchronousFetchRequest(fetchRequest: fetchRequest, completionBlock: {(result : NSAsynchronousFetchResult) -> Void in
            guard let answer = result.finalResult
                else { return }
            
            for data in answer
            {
                if data.name == nameToDelete
                {
                    self.persistentContainer.performBackgroundTask({(privContext : NSManagedObjectContext) -> Void in
                        do
                        {
                            privateContext.delete(data)
                            try privateContext.save()
                        }
                        catch let error
                        {
                            print(error.localizedDescription)
                        }
                    })
                    break
                }
            }
        })
        
        do
        {
            try privateContext.execute(asyncFetch)
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CourseProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
