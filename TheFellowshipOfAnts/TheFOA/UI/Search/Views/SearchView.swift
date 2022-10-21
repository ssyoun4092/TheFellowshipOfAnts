//
//  SearchView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit

import SnapKit

class SearchView: UIView {

    // MARK: - Properties
    
    var cancelButtonShouldShow: Bool {
        didSet {
            let inset: CGFloat = cancelButtonShouldShow ? 10 : 62
            searchBar.snp.updateConstraints {
                $0.trailing.equalToSuperview().inset(inset)
            }

            UIView.animate(withDuration: 0.3) {
                self.searchBar.superview?.layoutIfNeeded()
            }
        }
    }

    // MARK: - IBOutlets

    let searchBar = UISearchBar()
    let activityIndicator = UIActivityIndicatorView()
    let cancelButton = UIButton()
    let searchedStocksTableView = UITableView()
    let recentSearchView = RecentSearchListView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        self.cancelButtonShouldShow = true
        super.init(frame: frame)

        setupSearchBar()
        setupCancelLabel()
        setupSearchResultTableView()
        setupRecentSearchView()
        setupActivityIndicator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func setupSearchBar() {
        addSubview(searchBar)

        searchBar.placeholder = "종목 검색"
        searchBar.backgroundImage = UIImage()

        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
    }

    private func setupCancelLabel() {
        addSubview(cancelButton)

        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.titleLabel?.adjustsFontSizeToFitWidth = true

        cancelButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.top)
            $0.leading.equalTo(searchBar.snp.trailing).offset(10)
            $0.bottom.equalTo(searchBar.snp.bottom)
        }
    }

    private func setupSearchResultTableView() {
        addSubview(searchedStocksTableView)

        searchedStocksTableView.register(
            SearchingItemCell.self,
            forCellReuseIdentifier: SearchingItemCell.identifier)
        searchedStocksTableView.rowHeight = 60
        searchedStocksTableView.isHidden = true

        searchedStocksTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupRecentSearchView() {
        addSubview(recentSearchView)

        recentSearchView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
}
