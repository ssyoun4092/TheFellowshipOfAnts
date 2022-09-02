//
//  TabBarController.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/25.
//

import UIKit

class TabBarController: UITabBarController {
    private lazy var homeViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: HomeViewController())

        viewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            tag: 1
        )

        return viewController
    }()

    private lazy var searchViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: SearchViewController())

        viewController.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )

        return viewController
    }()

    private lazy var chatViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: ChatViewController())

        viewController.tabBarItem = UITabBarItem(
            title: "채팅",
            image: UIImage(systemName: "bubble.left"),
            tag: 1
        )

        return viewController
    }()

    private lazy var profileViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: ProfileViewController())

        viewController.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(systemName: "person"),
            tag: 1
        )

        return viewController
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemPurple
        viewControllers = [homeViewController, searchViewController, chatViewController, profileViewController]
    }
}
