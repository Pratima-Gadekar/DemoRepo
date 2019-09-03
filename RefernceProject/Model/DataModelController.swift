//
//  DataModelController.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import Foundation
import AmaranthineQueue

final class DataModelController
{
    //Variables --------------------------------------------------
    var taskQueue                       : OperationQueue                = OperationQueue()
    var localCache                      : AmaranthineQueue<SurveyModel> = AmaranthineQueue<SurveyModel>()
    lazy var persistentStoreDBHandle    : PersistentStoreManager        = PersistentStoreManager.createManager()
    
    
    //Singleton --------------------------------------------------
    static var modelController : DataModelController?
    static func createModelController() -> DataModelController
    {
        if nil == modelController
        {
            modelController = DataModelController()
        }
        return modelController!
    }
    
    private init()
    {
        
    }
    
    //Functions --------------------------------------------------
    /**
     This function caches the survey onto the local queue
     - important: This function does not perform data validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015 - version: 1.0*/
    @available(iOS, introduced: 11.0, message: "Write scheduling function")
    func cache(Survey newSurvey : SurveyModel)
    {
        localCache.add(Element: newSurvey)
    }
    
    /**
     This function schedules all the write operations from the local cache onto the queue
     - important: This function does not perform data validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015 - version: 1.0*/
    @available(iOS, introduced: 11.0, message: "Write scheduling function")
    func put()
    {
        for entry in localCache
        {
            let writeOperation = BlockOperation(block: {() -> Void in
                self.persistentStoreDBHandle.insertData(with: entry)
            })
            
            if nil != taskQueue.operations.last
            {
                writeOperation.addDependency(taskQueue.operations.last!)
            }
            taskQueue.addOperation(writeOperation)
        }
        do
        {
            try localCache.emptyQueue()
        }
        catch let error
        {
            print("Error emptying cache \(error)")
        }
    }
    
    /**
     This function schedules a read operation onto the queue
     - important: This function does not perform data validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015 - version: 1.0*/
    @available(iOS, introduced: 11.0, message: "Read scheduling function")
    func pullData(UpdateScreenWith updater : @escaping PersistentStoreManager.UIUpdaterClosure)
    {
        let readOperation = BlockOperation(block: {() -> Void in
            self.persistentStoreDBHandle.performBackgroundFetch(AndUpdateWith: updater)
        })
        
        if nil != taskQueue.operations.last
        {
            readOperation.addDependency(taskQueue.operations.last!)
        }
        taskQueue.addOperation(readOperation)
    }
    
    /**
     This function schedules a delete operation onto the queue
     - important: This function does not perform data validation
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015 - version: 1.0*/
    @available(iOS, introduced: 11.0, message: "Delete scheduling function")
    func delete(forName nameToDelete : String)
    {
        let deleteOperation = BlockOperation(block: {() -> Void in
            self.persistentStoreDBHandle.asyncDelete(nameToDelete: nameToDelete)
        })
        
        if nil != taskQueue.operations.last
        {
            deleteOperation.addDependency(taskQueue.operations.last!)
        }
        taskQueue.addOperation(deleteOperation)
    }
}
