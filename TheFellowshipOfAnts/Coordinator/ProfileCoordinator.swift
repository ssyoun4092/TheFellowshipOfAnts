//
//  ProfileCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/03.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: TabBarCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
