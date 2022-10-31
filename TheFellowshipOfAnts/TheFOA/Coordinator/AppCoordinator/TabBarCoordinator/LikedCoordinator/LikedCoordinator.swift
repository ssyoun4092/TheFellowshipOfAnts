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
        let viewModel = LikedViewModel(userDefaultUseCase: useCase)
        let vc = LikedViewController(viewModel: viewModel)
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
