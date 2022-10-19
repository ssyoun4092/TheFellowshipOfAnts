//
//  SearchViewController+Rx.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/16.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift
import SnapKit

class SearchViewController: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    let viewModel: SearchViewModel

    weak var coordinator: SearchCoordinator?

    // MARK: - IBOutlets

    let searchView = SearchView()

    // MARK: - Life Cycle

    init(viewModel: SearchViewModel) {
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

    override func viewDidLayoutSubviews() {
        searchView.searchedStocksTableView.separatorStyle = .none
    }

    private func bind(to viewModel: SearchViewModel) {
        rx.viewWillAppear
            .map { _ in () }
            .bind(to: viewModel.firstLoad)
            .disposed(by: disposeBag)

        searchView.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchBarText)
            .disposed(by: disposeBag)

        searchView.searchBar.rx.textDidBeginEditing
            .bind(to: viewModel.searchBarDidBeginEditing)
            .disposed(by: disposeBag)

        searchView.searchBar.rx.searchButtonClicked
            .bind(to: viewModel.searchButtonClicked)
            .disposed(by: disposeBag)

        searchView.cancelButton.rx.tap
            .bind(to: viewModel.didTapCancelButton)
            .disposed(by: disposeBag)

        searchView.recentSearchView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        searchView.recentSearchView.deleteAllButton.rx.tap
            .bind(to: viewModel.didTapDeleteAllButton)
            .disposed(by: disposeBag)

        searchView.searchedStocksTableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.didSelectSearchedStocksItem)
            .disposed(by: disposeBag)

        searchView.recentSearchView.collectionView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.pushToStockDetailViewController2)
            .disposed(by: disposeBag)

        viewModel.reloadRecentSearchedStocks
            .drive(searchView.recentSearchView.collectionView.rx.items) { [weak self] collectionView, row, recentSearchStock in
                guard let self = self else { return UICollectionViewCell() }
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecentSearchCell.identifier,
                    for: IndexPath(row: row, section: 0)
                ) as! RecentSearchCell

                cell.configure(with: recentSearchStock.companyName)
                cell.deleteLabel.rx.tapGesture()
                    .when(.recognized)
                    .map { _ in row }
                    .bind(to: viewModel.deleteRecentSearchedCellRow)
                    .disposed(by: self.disposeBag)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.searchedStocks
            .drive(searchView.searchedStocksTableView.rx.items) { tableView, row, searchedStock in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchingItemCell.identifier,
                    for: IndexPath(row: row, section: 0)
                ) as! SearchingItemCell

                cell.configure(with: searchedStock)

                return cell
            }
            .disposed(by: disposeBag)

        viewModel.push
            .drive(with: self) { owner, entity in
                let viewController = StockDetailViewController()
                viewController.symbol = entity.symbol
                viewController.companyName = entity.companyName
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)

        viewModel.activated
            .drive(with: self) { owner, isSearching in
                isSearching
                ? owner.searchView.activityIndicator.startAnimating()
                : owner.searchView.activityIndicator.stopAnimating()
            }
            .disposed(by: disposeBag)

        viewModel.hideRecentSearchView
            .distinctUntilChanged()
            .drive(with: self) { owner, isHidden in
                owner.searchView.recentSearchView.isHidden = isHidden
            }
            .disposed(by: disposeBag)

        viewModel.hideSearchedStocksView
            .distinctUntilChanged()
            .drive(with: self) { owner, isHidden in
                owner.searchView.searchedStocksTableView.isHidden = isHidden
            }
            .disposed(by: disposeBag)

        viewModel.hideCancelButton
            .distinctUntilChanged()
            .drive(with: self) { owner, _ in
                owner.animateCancelButton()
            }
            .disposed(by: disposeBag)

        viewModel.hideKeyboard
            .drive(with: self) { owner, _ in
                owner.hideKeyboard()
            }
            .disposed(by: disposeBag)
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }

    private func animateCancelButton() {
        searchView.cancelButtonShouldShow = !searchView.cancelButtonShouldShow
    }
}

extension SearchViewController {
    private func setupViews() {
        view.endEditing(true)

        view.addSubview(searchView)

        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidths = viewModel.getRecentSearchedStocksCellWidths()
        let cellWidth = cellWidths[indexPath.row]
        let xWidth = "X".size(
            withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 14,
                weight: .regular)]
        ).width
        let inset = CGFloat(15)
        let spacing = CGFloat(13)
        let totalWidth = cellWidth + xWidth + (2 * inset) + spacing

        return CGSize(width: totalWidth, height: 30)
    }
}
