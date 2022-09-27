import UIKit

import TheFellowshipOfAntsKey
import SnapKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    var searchItems: [SearchStock] = [] {
        didSet {
            if searchItems.isEmpty {
                searchView.searchedStocksTableView.isHidden = true
                searchView.recentSearchView.isHidden = false
                searchView.recentSearchView.collectionView.reloadData()
            } else {
                searchView.searchedStocksTableView.isHidden = false
                searchView.recentSearchView.isHidden = true
                searchView.searchedStocksTableView.reloadData()
            }
        }
    }

    weak var coordinator: SearchCoordinator?

    // MARK: - IBOutlets

    let searchView = SearchView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidLayoutSubviews() {
        searchView.searchedStocksTableView.separatorStyle = .none
    }

    private func translateKoreanToEnglish(text: String, completion: @escaping (String) -> Void) {
        let parameters = "source=ko&target=en&text=\(text)"
        let paramData = parameters.data(using: .utf8)
        let papagoURL = URL(string: "https://openapi.naver.com/v1/papago/n2mt")

        let clientID = "ASAlIspGHK5XDC_9NdDi"
        let clientSecret = "2CoRBE3tpY"

        var request = URLRequest(url: papagoURL!)
        request.httpMethod = "POST"
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpBody = paramData
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")

        let config = URLSessionConfiguration.default

        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            if let data = data {
                let str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? "왜 안돼"
                completion(str)
            }
            //통신 실패
            if let error = error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }

    @objc
    private func didTapDeleteAllButton() {
        print(#function)
        UserDefaultManager.recentSearches.removeAll()
        searchView.recentSearchView.collectionView.reloadData()
    }

    @objc
    private func didTapCancelButton() {
        view.endEditing(true)
        searchView.searchBar.snp.updateConstraints {
            $0.trailing.equalToSuperview().inset(10)
        }
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.searchView.searchBar.superview?.layoutIfNeeded()
        }
    }
}

extension SearchViewController {
    private func setupViews() {
        view.endEditing(true)

        view.addSubview(searchView)

        searchView.searchBar.delegate = self
        searchView.recentSearchView.collectionView.dataSource = self
        searchView.recentSearchView.collectionView.delegate = self
        searchView.searchedStocksTableView.dataSource = self
        searchView.searchedStocksTableView.delegate = self

        searchView.recentSearchView.deleteAllButton.addTarget(
            self,
            action: #selector(didTapDeleteAllButton),
            for: .touchUpInside
        )
        searchView.cancelButton.addTarget(
            self,
            action: #selector(didTapCancelButton),
            for: .touchUpInside
        )

        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func isContainKorean(item: String) -> Bool {
        let koreanRegister = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", koreanRegister)

        return predicate.evaluate(with: item)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty
        ? searchItems.removeAll()
        : NetworkService.fetchSearchingStocksInfo(text: searchText, completion: { result in
            switch result {
            case .success(let stockInfos):
                self.searchItems = stockInfos
            case .failure(let error):
                print(error)
            }
        })
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchView.searchBar.snp.updateConstraints {
            $0.trailing.equalToSuperview().inset(62)
        }
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.searchView.searchBar.superview?.layoutIfNeeded()
        }

        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }

        if isContainKorean(item: text) {
            NetworkService.translateKoreanToEnglish(text: text) { result in
                switch result {
                case .success(let translatedEnglish):
                    NetworkService.fetchSearchingStocksInfo(text: translatedEnglish) { result in
                        switch result {
                        case .success(let stockInfos):
                            self.searchItems = stockInfos
                        case .failure(let error):
                            print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}

