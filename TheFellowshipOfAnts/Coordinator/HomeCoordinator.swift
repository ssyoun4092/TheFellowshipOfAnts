//
//  HomeCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/03.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: TabBarCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewControllerRx()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func pushToStockDetailViewController(companyName: String, symbol: String) {
        let vc = StockDetailViewController()
        vc.companyName = companyName
        vc.symbol = symbol
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
