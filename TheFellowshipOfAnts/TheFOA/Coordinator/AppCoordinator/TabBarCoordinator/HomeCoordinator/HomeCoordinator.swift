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
        let repository = StocksRepositoryImpl()
        let useCase = StocksUseCaseImpl(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        let vc = HomeViewController(viewModel: viewModel)
        vc.coordinator = self

        navigationController.pushViewController(vc, animated: true)
    }

    func pushToStockDetailVC(companyName: String, symbol: String) {
        let stockRepository = StocksRepositoryImpl()
        let userDefaultRepository = UserDefaultCRUDRepositoryImpl()
        let stockUseCase = StocksUseCaseImpl(repository: stockRepository)
        let userDefaultUseCase = UserDefaultUseCaseImpl(repository: userDefaultRepository)

        let viewModel = StockDetailViewModel(stockUseCase: stockUseCase,
                                             userDefaultUseCase: userDefaultUseCase,
                                             symbol: symbol,
                                             companyName: companyName)
        let vc = StockDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
