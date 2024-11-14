//
//  SceneDelegate.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var loginType = UserDefaults.standard.integer(forKey: "loginType")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        start(scene: windowScene)
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    fileprivate func start(scene: UIWindowScene) {
        
        var newWindow: UIWindow?
        switch loginType {
        case 0:
            newWindow = showLoginController(scene: scene)
        default:
            newWindow = showMainController(scene: scene)
        }
        window = newWindow
        window?.makeKeyAndVisible()
    }
    
    private func showLoginController(scene: UIWindowScene) -> UIWindow {
        let controller = LoginViewController(viewModel: LoginViewModel())
        let navigationController = UINavigationController(rootViewController: controller)
       
        let newWindow = UIWindow(windowScene: scene)
        newWindow.rootViewController = navigationController
        
        return newWindow
    }
    
    private func showMainController(scene: UIWindowScene) -> UIWindow {
        let controller = MainTabBarController()
        let navigationController = UINavigationController(rootViewController: controller)
        
        let newWindow = UIWindow(windowScene: scene)
        newWindow.rootViewController = navigationController
        
        return newWindow
    }
    
    func switchToLogin() {
        guard let windowScene = window?.windowScene else { return }
        window = showLoginController(scene: windowScene)
        window?.makeKeyAndVisible()
    }
    
    func switchToMain() {
        guard let windowScene = window?.windowScene else { return }
        window = showMainController(scene: windowScene)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

