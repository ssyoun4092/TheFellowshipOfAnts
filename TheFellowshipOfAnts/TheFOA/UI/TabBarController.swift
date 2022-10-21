//
//  TabBarController.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/25.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties
    var coordinator: TabBarCoordinator?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemPurple
    }
}
