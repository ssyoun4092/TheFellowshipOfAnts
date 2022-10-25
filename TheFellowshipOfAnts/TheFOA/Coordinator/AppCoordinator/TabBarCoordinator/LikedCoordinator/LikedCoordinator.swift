//
//  LikedCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import UIKit

class LikedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: TabBarCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let repository = UserDefaultCRUDRepositoryImpl()
        let useCase = UserDefaultUseCaseImpl(repository: repository)
        let viewModel = LikedViewModel(useCase: useCase)
        let vc = LikedViewController(viewModel: viewModel)
        vc.coordinator = self

        navigationController.pushViewController(vc, animated: true)
    }
}
