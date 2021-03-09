//
//  AppDelegate.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 05/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

typealias MyresponseType = (User) -> Void

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let myblock:MyresponseType = { u in
            print(u.name)
        }
        
        
        getUser(id: "savr", pass: "pass", response: myblock)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
    }
    
    struct User {
        let name:String
    }

    func getUser(id:String, pass:String, response:@escaping MyresponseType) {
        print("Disvvv")
        DispatchQueue.global(qos: .background).async {
            let user = User(name: "satish")
            
            DispatchQueue.main.async {
                response(user)
            }
            
        }
        
    }

    func onRespose(of user:User) {
        
    }
}

