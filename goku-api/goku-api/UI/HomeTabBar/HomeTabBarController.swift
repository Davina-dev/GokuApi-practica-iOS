//
//  HomeTabBarController.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 20/12/22.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTabs()
        
    }
    
    private func setupTabs(){
        let navigationController1 = UINavigationController(rootViewController: TableViewcontroller())
        let tabImage = UIImage(systemName: "text.justify")!
        navigationController1.tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag: 0)
        
        
        let navigationController2 = UINavigationController(rootViewController: CollectionViewController())
        let tabImg = UIImage(systemName: "square.grid.3x3.topleft.filled")!
        navigationController2.tabBarItem = UITabBarItem(title: "CollectionView", image: tabImg, tag: 1)
        
        viewControllers = [navigationController1, navigationController2]
    }
    
    //color
    private func setupLayout(){
        tabBar.backgroundColor = .systemBackground
    }
}
