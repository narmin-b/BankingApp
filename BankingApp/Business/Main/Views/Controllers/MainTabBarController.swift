//
//  MainTabBarController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white

        tabBar.tintColor = .black

        tabBar.unselectedItemTintColor = .gray
        
       
    }
    
    func setUpTabBar() {
        let mainItem = MainViewController()
        let mainIcon = UITabBarItem(title: "Home", image: UIImage(named: "mainBarIcon"), selectedImage: UIImage(named: "selectedMainBarIcon"))
        mainItem.tabBarItem = mainIcon
        
        let moreItem = MoreViewController()
        let moreIcon = UITabBarItem(title: "More", image: UIImage(named: "moreBarIcon"), selectedImage: UIImage(named: "selectedMoreBarIcon"))
        moreItem.tabBarItem = moreIcon
        
        let controllers = [mainItem, moreItem]
        self.viewControllers = controllers
    }
}

//
//public class TabBarViewController: UITabBarController {
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupViewControllers()
//    }
//
//    func setupViewControllers() {
//        let firstVC = FirstViewController()
//        firstVC.name = nameVal
//        firstVC.tabBarItem.image = UIImage(named: "ico_active", in: Bundle(for: TabBarViewController.self), compatibleWith: nil)
//        firstVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0);
//
//        let secondVC = SecondViewController()
//        secondVC.name = nameVal
//        secondVC.tabBarItem.image = UIImage(named: "ico_active", in: Bundle(for: TabBarViewController.self), compatibleWith: nil)
//        secondVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0);
//
//        let thirdVC = ThirdViewController()
//        thirdVC.name = nameVal
//        thirdVC.tabBarItem.image = UIImage(named: "ico_active", in: Bundle(for: TabBarViewController.self), compatibleWith: nil)
//        thirdVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0);
//
//        viewControllers = [firstVC, secondVC, thirdVC]
//    }
//}
