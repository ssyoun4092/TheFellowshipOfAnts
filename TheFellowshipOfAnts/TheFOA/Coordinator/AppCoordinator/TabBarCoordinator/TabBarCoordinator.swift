//
//  TabBarCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/03.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self

        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()

        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        childCoordinators.append(searchCoordinator)
        searchCoordinator.start()

        let chatNavigationController = UINavigationController()
        chatNavigationController.tabBarItem = UITabBarItem(
            title: "채팅",
            image: UIImage(systemName: "bubble.left"),
            tag: 2
        )
        let chatCoordinator = ChatCoordinator(navigationController: chatNavigationController)
        childCoordinators.append(chatCoordinator)
        chatCoordinator.start()

        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(systemName: "person"),
            tag: 3
        )
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()

        tabBarController.modalPresentationStyle = .fullScreen

        tabBarController.viewControllers = [
            homeNavigationController,
            searchNavigationController,
            chatNavigationController,
            profileNavigationController
        ]

        navigationController.present(tabBarController, animated: false)
    }

    func childDidFinish(_ coordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    }
}
