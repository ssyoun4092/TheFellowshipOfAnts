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

// TODO: - UpDown 로직 구현

class HomeViewControllerRx: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    private var viewModel = HomeViewModel()

    weak var coordinator: HomeCoordinator?

    // MARK: - IBOutlet

    let homeView = HomeView()

    // MARK: - LifeCycle

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

        homeView.indicesSectionView.collectionView.rx.currentPage
            .bind(to: homeView.indicesSectionView.pageControl.rx.currentPage)
            .disposed(by: disposeBag)

        viewModel.stockIndices
            .drive(homeView.indicesSectionView.collectionView.rx.items(
                cellIdentifier: IndiceCollectionViewCell.identifier,
                cellType: IndiceCollectionViewCell.self)
            ) { index, stockIndice, cell in
                cell.configure(with: stockIndice, upDown: .up)
            }
            .disposed(by: disposeBag)

        viewModel.top20Stocks
            .drive(homeView.stockRankSectionView.collectionView.rx.items(
                cellIdentifier: StockRankCollectionViewCell.identifier,
                cellType: StockRankCollectionViewCell.self)
            ) { index, rankStock, cell in
                cell.configure(with: rankStock)
            }
            .disposed(by: disposeBag)

        viewModel.commodityCellViewModels
            .drive(homeView.majorCommoditiesSectionView.collectionView.rx.items(
                cellIdentifier: MajorCarouselCell.identifier,
                cellType: MajorCarouselCell.self)
            ) { index, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)

        viewModel.etfCellViewModels
            .drive(homeView.majorETFSectionView.collectionView.rx.items(
                cellIdentifier: MajorCarouselCell.identifier,
                cellType: MajorCarouselCell.self)
            ) { index, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewControllerRx {
    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(homeView)

        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension Reactive where Base: UIScrollView {
    var currentPage: Observable<Int> {
        return didEndDecelerating.map { () in
            let offset = self.base.contentOffset.x
            let width = UIScreen.main.bounds.width
            let currentPage = Int(offset / width)

            return currentPage
        }
    }
}
