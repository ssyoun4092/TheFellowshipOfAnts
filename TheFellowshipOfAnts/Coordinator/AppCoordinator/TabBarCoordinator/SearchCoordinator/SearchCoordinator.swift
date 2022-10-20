//
//  SearchCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/03.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: TabBarCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let stockRepository = StocksRepositoryImpl()
        let stockUseCase = StocksUseCaseImpl(repository: stockRepository)

        let translateRepository = TranslateRepositoryImpl()
        let translateUseCase = TranslateUseCaseImpl(repository: translateRepository)

        let userDefaultRepository = UserDefaultCRUDRepositoryImpl()
        let userDefaultUseCase = UserDefaultUseCaseImpl(repository: userDefaultRepository)

        let viewModel = SearchViewModel(stockUseCase: stockUseCase, translateUseCase: translateUseCase, userDefaultUseCase: userDefaultUseCase)
        let vc = SearchViewController(viewModel: viewModel)
        
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    // TODO: - pushToStockDetailVC 구현해야됨

//    func pushToStockDetailVC(companyName: String, symbol: String) {
//        let vc = StockDetailViewController()
//        vc.companyName = companyName
//        vc.symbol = symbol
//    }
}
