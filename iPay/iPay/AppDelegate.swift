//
//  AppDelegate.swift
//  iPay
//
//  Created by Diego on 3/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var transactions = [Transaction]()
    
    let fileName:String = "data.txt"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //TODO: Load database
        
        if let content = loadFileContent() {
            parseContent(content: content)
        } else {
            print("Empty content")
        }
        
        return true
    }
    
    func loadFileContent() -> String? {
        
    
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(fileName)
            
            
            //reading
            do {
                let text = try String(contentsOf: path, encoding: String.Encoding.utf8)
                return text
            }
            catch {
            }
        }
        
        return nil
    }
    
    func parseContent(content:String) -> Void {
        let strArray:[String] = content.components(separatedBy: "\n") //[String]
        
        for( _, element) in strArray.enumerated(){
            let str = element
            if(str.characters.count > 0){
                let newTransaction = Transaction.init(text: str)
                transactions.append(newTransaction)
            }
        }
        
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
        
        //TODO: Save database
        let content = getDatabaseText()
        
        writeToFile(content: content)
    }
    
    func writeToFile(content:String) -> Void {
        
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(fileName)
            
            //writing
            do {
                try content.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                
            }
            
        }
    }
    
    
    
    func getDatabaseText() -> String {
        
        var text:String = ""
        for (_, element) in transactions.enumerated() {
            //print("Item \(index): \(element)")
            let t:Transaction = element
            text = text + "\(t.kind)*\(t.ammount)*\(t.date)*\(t.text!)\n"
        }
        
        return text
    }
}

