//
//  SearchViewController+Rx.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/16.
//

import UIKit

import TheFellowshipOfAntsKey
import RxSwift
import RxCocoa
import SnapKit

class SearchViewControllerRx: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()

    let recentSearchList = UserDefaultManager.shared.recentSearches

    weak var coordinator: SearchCoordinator?

    // MARK: - IBOutlets

    let searchView = SearchView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind(to: viewModel)
    }

    override func viewDidLayoutSubviews() {
        searchView.searchedStocksTableView.separatorStyle = .none
    }

    private func bind(to viewModel: SearchViewModel) {
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

        searchView.searchedStocksTableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.didSelectSearchedStocksItem)
            .disposed(by: disposeBag)

        viewModel.searchedStocks
            .drive(searchView.searchedStocksTableView.rx.items) { tableView, row, data in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchingItemCell.identifier,
                    for: IndexPath(row: row, section: 0)
                ) as! SearchingItemCell

                cell.configure(with: data)

                return cell
            }
            .disposed(by: disposeBag)

        viewModel.activated
            .drive(with: self, onNext: { owner, isSearching in
                isSearching
                ? owner.searchView.activityIndicator.startAnimating()
                : owner.searchView.activityIndicator.stopAnimating()
            })
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

extension SearchViewControllerRx {
    private func setupViews() {
        view.endEditing(true)

        view.addSubview(searchView)

//        searchView.recentSearchView.collectionView.dataSource = self
//        searchView.recentSearchView.collectionView.delegate = self
//        searchView.searchResultTableView.dataSource = self
//        searchView.searchResultTableView.delegate = self

        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
