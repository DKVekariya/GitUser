//
//  SceneDelegate.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 05/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let context = URLContexts.first(where: { $0.url.scheme?.lowercased() == "demogithub" }), let query = context.url.query {
            if let code = query.split(separator: "=").last {
                NotificationCenter.default.post(name: Notification.Name("auth-success"), object: code)
            }
        }
        
    }
}

