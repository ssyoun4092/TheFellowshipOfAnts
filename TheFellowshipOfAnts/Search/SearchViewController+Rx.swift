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

//    var searchItems: [SymbolSearchInfo] = [] {
//        didSet {
//            if searchItems.isEmpty {
//                searchView.searchResultTableView.isHidden = true
//                searchView.recentSearchView.isHidden = false
//            } else {
//                searchView.searchResultTableView.isHidden = false
//                searchView.recentSearchView.isHidden = true
//                searchView.searchResultTableView.reloadData()
//            }
//        }
//    }

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
        searchView.searchResultTableView.separatorStyle = .none
    }

    private func bind(to viewModel: SearchViewModel) {
        searchView.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchBarText)
            .disposed(by: disposeBag)

        searchView.searchBar.rx.textDidBeginEditing
            .bind(to: viewModel.searchBarDidBeginEditing)
            .disposed(by: disposeBag)

        searchView.searchBar.rx.textDidEndEditing
            .bind(to: viewModel.searchBarDidEndEditing)
            .disposed(by: disposeBag)

        viewModel.shouldHideRecentSearchItems
            .withUnretained(self)
            .bind { owner, isHidden in
                owner.searchView.recentSearchView.isHidden = isHidden
                owner.searchView.searchResultTableView.isHidden = !isHidden
            }
            .disposed(by: disposeBag)
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
}

extension SearchViewControllerRx {
    private func setupViews() {
        view.endEditing(true)

        view.addSubview(searchView)

        searchView.searchBar.delegate = self
//        searchView.recentSearchView.collectionView.dataSource = self
//        searchView.recentSearchView.collectionView.delegate = self
//        searchView.searchResultTableView.dataSource = self
//        searchView.searchResultTableView.delegate = self

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

    private func fetchSymbols(text: String, completion: @escaping ([SymbolSearchInfo]) -> Void) {
        API<SymbolSearch>(
            baseURL: TheFellowshipOfAntsRequest.SymbolSearch.baseURL,
            params: [
                TheFellowshipOfAntsRequest.SymbolSearch.ParamsKey.symbol: text
            ],
            apiKey: TheFellowshipOfAntsRequest.SymbolSearch.apikey
        ).fetch { result in
            switch result {
            case .success(let searchedSymbols):
                let filteredSymbols = searchedSymbols.symbolSearchInfos
                    .filter { $0.country == "United States" }
                completion(filteredSymbols)

            case .failure(let error):
                print(error)
            }
        }
    }

//    private func fetchLogos(text: String, completion: @escaping ([SymbolSearchInfo]) -> Void) {
//        let dispatchGroup = DispatchGroup()
//        var tempSearchInfos: [SymbolSearchInfo] = []
//        fetchSymbols(text: text) { searchInfos in
//            tempSearchInfos = searchInfos
//            for (index, searchInfo) in searchInfos.enumerated() {
//                dispatchGroup.enter()
//                API<Logo>(
//                    baseURL: TheFellowshipOfAntsRequest.Logo.baseURL,
//                    params: [
//                        TheFellowshipOfAntsRequest.Logo.ParamsKey.symbol: searchInfo.symbol
//                    ],
//                    apiKey: TheFellowshipOfAntsRequest.Logo.apiKey
//                ).fetch { result in
//                    switch result {
//                    case .success(let logo):
//                        print(logo.url)
//                        tempSearchInfos[index].urlString = logo.url
//                        dispatchGroup.leave()
//                    case .failure(let error):
//                        print(error)
//                        dispatchGroup.leave()
//                    }
//                }
//            }
//
//            dispatchGroup.notify(queue: .main) {
//                completion(tempSearchInfos)
//            }
//        }
//    }
}

extension SearchViewControllerRx: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchText.isEmpty
//        ? searchItems.removeAll()
//        : fetchLogos(text: searchText) { [weak self] searchInfos in
//            self?.searchItems = searchInfos
//        }
//    }

//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchView.searchResultTableView.reloadData()
//        searchView.searchResultTableView.isHidden = false
//        searchView.recentSearchView.isHidden = true
//    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }

        if isContainKorean(item: text) {
            translateKoreanToEnglish(text: text) { translatedString in
                print(translatedString)
            }
        }
        searchBar.resignFirstResponder()
    }
}

