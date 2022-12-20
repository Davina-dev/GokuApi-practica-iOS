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
        let tableViewController = TableViewcontroller()
        let tabImage = UIImage(systemName: "text.justify")!
        tableViewController.tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag: 0)
        
        let collectionViewController = CollectionViewController()
        let tabImg = UIImage(systemName: "square.grid.3x3.topleft.filled")!
        collectionViewController.tabBarItem = UITabBarItem(title: "CollectionView", image: tabImage, tag:1)
        
        
        viewControllers = [tableViewController, collectionViewController]
    }
    
    //color
    private func setupLayout(){
        tabBar.backgroundColor = .systemBackground
    }
}
