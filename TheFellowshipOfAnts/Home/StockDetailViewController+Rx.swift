//
//  StockDetailViewController+Rx.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class StockDetailViewControllerRx: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    let viewModel: StockDetailViewModel

    // MARK: - IBOutlets

    let homeView = HomeView()

    // MARK: - Life Cycle

    init(viewModel: StockDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind(to: viewModel)
    }

    private func bind(to viewModel: StockDetailViewModel) {
        rx.viewWillAppear
            .map { _ in () }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
    }
}

extension StockDetailViewControllerRx {
    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(homeView)

        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
