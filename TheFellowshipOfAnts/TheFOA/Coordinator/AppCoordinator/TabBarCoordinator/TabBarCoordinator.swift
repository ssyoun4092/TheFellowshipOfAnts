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
        startHomeCoordinator(navigationController: homeNavigationController)

        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        startSearchCoordinator(navigationController: searchNavigationController)

//        let chatNavigationController = UINavigationController()
//        chatNavigationController.tabBarItem = UITabBarItem(
//            title: "채팅",
//            image: UIImage(systemName: "bubble.left"),
//            tag: 2
//        )
//        startChatCoordinator(navigationController: chatNavigationController)

        let likedNavigationController = UINavigationController()
        likedNavigationController.tabBarItem = UITabBarItem(
            title: "좋아요",
            image: UIImage(systemName: "heart"),
            tag: 2
        )
        startLikedCoordinator(navigationController: likedNavigationController)

        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(systemName: "person"),
            tag: 3
        )
        startProfileCoordinator(navigationController: profileNavigationController)

        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.viewControllers = [
            homeNavigationController,
            searchNavigationController,
            likedNavigationController,
            profileNavigationController
        ]

        navigationController.present(tabBarController, animated: false)
    }

    func childDidFinish(_ coordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    }
}

extension TabBarCoordinator {
    private func startHomeCoordinator(navigationController: UINavigationController) {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }

    private func startSearchCoordinator(navigationController: UINavigationController) {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        childCoordinators.append(searchCoordinator)
        searchCoordinator.start()
    }

    private func startChatCoordinator(navigationController: UINavigationController) {
        let chatCoordinator = ChatCoordinator(navigationController: navigationController)
        childCoordinators.append(chatCoordinator)
        chatCoordinator.start()
    }

    private func startLikedCoordinator(navigationController: UINavigationController) {
        let likedCoordinator = LikedCoordinator(navigationController: navigationController)
        childCoordinators.append(likedCoordinator)
        likedCoordinator.start()
    }

    private func startProfileCoordinator(navigationController: UINavigationController) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
}
