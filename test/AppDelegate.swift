//
//  AppDelegate.swift
//  test
//  Copyright © 2019 BENNOUR EL FAHSI. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        checkDataStore()

        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreData.saveContext()
    }

    func checkDataStore() {
        let moc = coreData.persistentContainer.viewContext
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            let bookCount = try moc.count(for: request)
            
            if bookCount == 0 {
                uploadSampleData()
            }
        }
        catch {
            fatalError("Error in counting movie")
        }
    }
    
    
    ////GET DATA
    func uploadSampleData() {
        
        let moc = coreData.persistentContainer.viewContext
        Alamofire.request("https://jsonplaceholder.typicode.com/photos").responseString { response in
            if let JSON = response.result.value {
                let data = JSON.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
                     
  
                        for json in jsonArray {
                            
                            let bookData = json as [String: AnyObject]
                            let book = Book(context: moc)
                            
                            guard let name = bookData["title"] else {
                                return
                            }
                            book.name = name as? String
                            
                            book.image = bookData["thumbnailUrl"] as? String
                
                        }
                                            
                       print(jsonArray)
                
                    }
                    self.coreData.saveContext()

//                    self.saveCont()

                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        

        }
        
    
    func saveCont() {
    
                    coreData.saveContext()
        
        }
    }




