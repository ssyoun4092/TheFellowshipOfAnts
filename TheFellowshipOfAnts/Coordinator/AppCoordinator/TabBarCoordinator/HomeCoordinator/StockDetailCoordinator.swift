//
//  StockDetailCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import UIKit

class StockDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: HomeCoordinator?

    var symbol: String?
    var companyName: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        let repository = StocksRepositoryImpl()
//        let useCase = StocksUseCaseImpl(repository: repository)
//        let viewModel = StockDetailViewModel(useCase: useCase)
//        let vc = StockDetailViewControllerRx(viewModel: viewModel)
//        vc.symbol = symbol
//        vc.companyName = companyName
//
//        navigationController.pushViewController(vc, animated: true)
    }
}
