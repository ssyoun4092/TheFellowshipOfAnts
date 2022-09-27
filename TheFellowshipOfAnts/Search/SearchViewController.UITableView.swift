//
//  SearchViewController.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchingItemCell.identifier,
            for: indexPath) as? SearchingItemCell
        else {
            return UITableViewCell()
        }
//        let searchInfo = searchItems[indexPath.row]
//        cell.configure(with: searchInfo)

        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let companyName = searchItems[indexPath.row].instrumentName
        let symbol = searchItems[indexPath.row].symbol
        let viewController = StockDetailViewController()
        viewController.symbol = symbol
        viewController.companyName = companyName

        if UserDefaultManager.recentSearches.contains(where: { $0.first == companyName }) {
            let index = UserDefaultManager.recentSearches.firstIndex { $0[0] == companyName }!
            UserDefaultManager.recentSearches.remove(at: index)
        }
        UserDefaultManager.recentSearches.append([companyName, symbol])

        navigationController?.pushViewController(viewController, animated: true)
    }
}
