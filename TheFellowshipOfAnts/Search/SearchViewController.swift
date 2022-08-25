import UIKit
import SnapKit
import SwiftUI

class SearchViewController: UIViewController {
    private var searchItems: [String] = [
        "애플",
        "알파벳",
        "엔비디아",
        "테슬라"
    ]

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "종목 검색"
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self

        return searchBar
    }()

    private let recentSearchView = RecentSearchListView()

    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchingItemCell.self, forCellReuseIdentifier: SearchingItemCell.identifer)
        tableView.rowHeight = 60
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layout()
    }

    override func viewDidLayoutSubviews() {
        searchResultTableView.separatorStyle = .none
    }
}

extension SearchViewController {
    private func layout() {
        view.addSubviews([searchBar, recentSearchView, searchResultTableView])

        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }

        recentSearchView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchResultTableView.reloadData()
        searchResultTableView.isHidden = false
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchResultTableView.isHidden = true
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchingItemCell.identifer, for: indexPath) as? SearchingItemCell else { return UITableViewCell() }

        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

}

struct SearchViewControllerPreView: PreviewProvider {
    static var previews: some View {
        SearchViewController().toPreview()
    }
}
