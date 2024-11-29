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
        
        configureView()
        setUpTabBar()
    }
    
    fileprivate func configureView() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
    
    fileprivate func setUpTabBar() {
        let mainItem = MainViewController(viewModel: MainViewModel())
        let mainIcon = UITabBarItem(title: "Home", image: UIImage(named: "mainBarIcon"), selectedImage: UIImage(named: "selectedMainBarIcon"))
        mainItem.tabBarItem = mainIcon
        
        let moreItem = MoreViewController()
        let moreIcon = UITabBarItem(title: "More", image: UIImage(named: "moreBarIcon"), selectedImage: UIImage(named: "selectedMoreBarIcon"))
        moreItem.tabBarItem = moreIcon
        
        let controllers = [mainItem, moreItem]
        self.viewControllers = controllers
    }
}
