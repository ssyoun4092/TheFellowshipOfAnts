//
//  SearchView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit

import SnapKit

class SearchView: UIView {

    // MARK: - IBOutlets

    let searchBar = UISearchBar()
    let cancelButton = UIButton()
    let searchResultTableView = UITableView()
    let recentSearchView = RecentSearchListView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSearchBar()
        setupCancelLabel()
        setupSearchResultTableView()
        setupRecentSearchView()
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
        addSubview(searchResultTableView)

        searchResultTableView.register(
            SearchingItemCell.self,
            forCellReuseIdentifier: SearchingItemCell.identifier)
        searchResultTableView.rowHeight = 60
        searchResultTableView.isHidden = true

        searchResultTableView.snp.makeConstraints {
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
}
