//
//  SceneDelegate.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow(frame: UIScreen.main.bounds)
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarC = setupTabBarController()
        let navigation = UINavigationController(rootViewController: tabBarC)
        
        navigation.navigationBar.isTranslucent = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance

        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        lineView.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 0.2)

        tabBarC.tabBar.addSubview(lineView)
        tabBarC.tabBar.barTintColor = UIColor.init(rgb: 0xFF4A648C)
//
        window?.windowScene = windowScene
        window?.rootViewController = navigation
        
        window?.makeKeyAndVisible()
    }
    
    func setupTabBarController() -> UITabBarController {
        let tabBarController: UITabBarController = UITabBarController()
        let mainStorboard = UIStoryboard(name: "Main", bundle: nil)
        ///HomePageViewController
        let homeVC = mainStorboard.instantiateViewController(withIdentifier: "HomeViewController")
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let menuVC = mainStorboard.instantiateViewController(withIdentifier: "OtherTestViewController")
        menuVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        tabBarController.setViewControllers([homeVC, menuVC], animated: true)
        return tabBarController
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

