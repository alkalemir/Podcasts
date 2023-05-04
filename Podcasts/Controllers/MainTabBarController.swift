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
            makeNavController(UIViewController.self, title: "Favorites"),
            makeNavController(SearchController.self, title: "Search"),
            makeNavController(UIViewController.self, title: "Downloads")
        ]
        
        setupPlayerDetailsView()
    }
    
    func minimizePlayerDetails() {
        maximizedTopAnchor.constant = view.frame.height
        maximizedTopAnchor.isActive = false
        minimizedTopAnchor.isActive = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            self.tabBar.transform = .identity
        }
        print("called")
    }
    
    func maximizePlayerDetails(episode: Episode) {
        maximizedTopAnchor.constant = 0
        maximizedTopAnchor.isActive = true
        minimizedTopAnchor.isActive = false
        playerDetailView.episode = episode
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.tabBar.transform = .init(translationX: 0, y: 100)
            self.view.layoutIfNeeded()
        }
    }
    
    var maximizedTopAnchor: NSLayoutConstraint!
    var minimizedTopAnchor: NSLayoutConstraint!
    let playerDetailView = PlayerDetailView.initFromNib()

    private func setupPlayerDetailsView() {
        playerDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(playerDetailView, belowSubview: tabBar)
        NSLayoutConstraint.activate([
            playerDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        maximizedTopAnchor = playerDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchor.isActive = true
        
        minimizedTopAnchor = playerDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
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
