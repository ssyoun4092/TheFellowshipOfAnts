//
//  HomeViewController+Rx.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class HomeViewControllerRx: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    let viewModel = HomeViewModel()

    weak var coordinator: HomeCoordinator?

    // MARK: - IBOutlet

    let homeView = HomeView()

    // MARK: - LifeCycle

    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        rx.viewDidLoad
//            .map { _ in () }
//            .bind(to: viewModel.firstLoad)
//            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind(to: viewModel)
//        fetchMajorStockIndexes()
//        crawlTop20Stocks()
//        crawlCommodities()
//        fetchETFs()
    }

    private func bind(to viewModel: HomeViewModel) {
        rx.viewWillAppear
            .map { _ in () }
            .bind(to: viewModel.firstLoad)
            .disposed(by: disposeBag)

        viewModel.stockIndices
            .drive(with: self) { owner, stockIndices in
                print("stockIndices:", stockIndices)
            }
            .disposed(by: disposeBag)

        viewModel.top20Stocks
            .drive(homeView.stockRankSectionView.collectionView.rx.items(
                cellIdentifier: StockRankCollectionViewCell.identifier,
                cellType: StockRankCollectionViewCell.self)
            ) { index, entity, cell in
                cell.configure(with: entity)
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewControllerRx {
    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(homeView)

//        homeView.indicesSectionView.collectionView.dataSource = self
//        homeView.indicesSectionView.collectionView.delegate = self
//        homeView.stockRankSectionView.collectionView.dataSource = self
//        homeView.stockRankSectionView.collectionView.delegate = self
//        homeView.majorCommoditiesSectionView.collectionView.dataSource = self
//        homeView.majorCommoditiesSectionView.collectionView.delegate = self
//        homeView.majorETFSectionView.collectionView.dataSource = self
//        homeView.majorETFSectionView.collectionView.delegate = self

        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
