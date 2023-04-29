//
//  MainTabBarController.swift
//  Podcasts
//
//  Created by Emir Alkal on 29.04.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = .purple
        setupAppearance()
    
        viewControllers = [
            makeNavController(ViewController.self, title: "Favorites"),
            makeNavController(SearchController.self, title: "Search"),
            makeNavController(ViewController.self, title: "Downloads")
        ]
    }
    
    private func makeNavController<T: UIViewController>(_ type: T.Type, title: String) -> UINavigationController {
        let controller = T()
        controller.navigationItem.title = title
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = .init(named: title.lowercased())
        return navController
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().prefersLargeTitles = true
        
        let navApperance = UINavigationBarAppearance()
        navApperance.configureWithOpaqueBackground()
        
        UINavigationBar.appearance().scrollEdgeAppearance = navApperance
        UINavigationBar.appearance().standardAppearance = navApperance
    }
}
