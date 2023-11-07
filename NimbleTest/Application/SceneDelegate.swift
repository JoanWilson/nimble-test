//
//  SceneDelegate.swift
//  NimbleTest
//
//  Created by Joan Wilson Oliveira on 03/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController: UIViewController = getInitialViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func getInitialViewController() -> UIViewController {
        if (LocalRepository.shared.getTokens()?.data.attributes?.accessToken) != nil {
            return SurveyFactory.makeViewController()
        } else {
            return LoginFactory.makeViewController()
        }
    }
}


