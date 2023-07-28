//
//  QuestionMainTabBarDependencyContainer.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class DeliveryMenuMainTabBarDependencyContainer {
    
//    func makeMainTabBarController() -> UITabBarController {
//        
//        let sharedAPIManager: APIManager = createAPIManager()
//        
//        let dishesViewController = {
//            self.createDishesViewController(apiManager: sharedAPIManager)
//        }
//        
//        let basketViewController = {
//            self.createBasketViewController(apiManager: sharedAPIManager)
//        }
//        
//        let tabBar = UITabBarController()
//        let appearance = UITabBarAppearance()
//        tabBar.tabBar.clipsToBounds = true
//        
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .clear
//        appearance.backgroundImage = Images.tabBarBackgroundImage.image
//        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Colors.General.selectedButton]
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.stackedLayoutAppearance.selected.iconColor = Colors.General.selectedButton
//        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
//        
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//        tabBar.viewControllers = [
//            createTabBarItem(
//                for: dishesViewController(),
//                withTitle: MainTabBarItems.menu.name,
//                withImage: MainTabBarItems.menu.image,
//                withTag: 0
//            ),
//            createTabBarItem(
//                for: basketViewController(),
//                withTitle: MainTabBarItems.basket.name,
//                withImage: MainTabBarItems.basket.image,
//                withTag: 1
//            )
//        ]
//        return tabBar
//    }
//    
//    private func createDishesViewController(apiManager: APIManager) -> DishesViewController {
//        let viewModel = createDishesViewModel(apiManager: apiManager)
//        return DishesViewController(viewModel: viewModel)
//    }
//    
//    private func createBasketViewController(apiManager: APIManager) -> BasketViewController {
//        let viewModel = createBasketViewModel(apiManager: apiManager)
//        return BasketViewController(viewModel: viewModel)
//    }
//    
//    private func createDishesViewModel(apiManager: APIManager) -> DishesViewModel {
//        return DishesViewModel(apiManager: apiManager)
//    }
//    
//    private func createBasketViewModel(apiManager: APIManager) -> BasketViewModel {
//        return BasketViewModel(apiManager: apiManager)
//    }
//    
//    private func createAPIManager() -> APIManager {
//        return APIManager()
//    }
//    
//    private func createTabBarItem(for vc: UIViewController, withTitle: String, withImage: UIImage, withTag: Int) -> UINavigationController {
//        let navVC = UINavigationController()
//        navVC.navigationBar.isHidden = true
//        vc.tabBarItem = UITabBarItem(title: withTitle, image: withImage, tag: withTag)
//        navVC.viewControllers = [vc]
//        return navVC
//    }
}
