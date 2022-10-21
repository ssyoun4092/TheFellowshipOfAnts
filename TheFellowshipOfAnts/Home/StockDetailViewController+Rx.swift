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

    let stockDetailView = StockDetailView()

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

        viewModel.stockPrices
            .drive(with: self) { owner, prices in
                owner.stockDetailView.stockGraphChartView.configure(with: prices, upDown: .up)
            }
            .disposed(by: disposeBag)

        viewModel.stockOverview
            .drive(stockDetailView.overviewCollectionView.rx.items(
                cellIdentifier: StockOverviewCollectionViewCell.identifier,
                cellType: StockOverviewCollectionViewCell.self)
            ) { _, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)

        viewModel.stockIncomeStatements
            .drive(with: self) { owner, viewModel in
                owner.stockDetailView.bind(to: viewModel)
            }
            .disposed(by: disposeBag)
    }
}

extension StockDetailViewControllerRx {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stockDetailView)

        stockDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
