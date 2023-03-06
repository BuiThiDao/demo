//
//  MainTableViewController.swift
//  movie_ios
//
//  Created by user on 03/03/2023.
//

import UIKit

class MainTableViewController: UITabBarController {
    var homeViewController: HomeViewController!
//    var secondViewController: HomeViewController!
//    var actionViewController: HomeViewController!
//    var thirdViewController: HomeViewController!
//    var fourthViewController: HomeViewController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
       

        homeViewController = HomeViewController()
//        secondViewController = HomeViewController()
//        actionViewController = HomeViewController()
//        thirdViewController = HomeViewController()
//        fourthViewController = HomeViewController()
        
        homeViewController.tabBarItem.image = UIImage(named: "house")
        homeViewController.tabBarItem.selectedImage =
        UIImage(named: "house")
//        secondViewController.tabBarItem.image = UIImage(named: "second")
//        secondViewController.tabBarItem.selectedImage = UIImage(named: "house")
//        actionViewController.tabBarItem.image = UIImage(named: "action")
//        actionViewController.tabBarItem.selectedImage = UIImage(named: "house")
//        thirdViewController.tabBarItem.image = UIImage(named: "third")
//        thirdViewController.tabBarItem.selectedImage = UIImage(named: "house")
//        fourthViewController.tabBarItem.image = UIImage(named: "fourth")
//        fourthViewController.tabBarItem.selectedImage = UIImage(named: "house")
        viewControllers = [homeViewController]
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            //tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController.isKind(of: ActionViewController.self) {
//            let vc =  ActionViewController()
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true, completion: nil)
//            return false
//        }
        return false
    }
    
}
