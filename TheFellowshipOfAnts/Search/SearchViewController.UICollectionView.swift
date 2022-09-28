//
//  SearchViewController.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/12.
//

import UIKit

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        print("=======")

        return UserDefaultManager.recentSearches.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentSearchCell.identifier,
            for: indexPath) as? RecentSearchCell
        else {
            return UICollectionViewCell()
        }
        let reversedIndexPathRow = UserDefaultManager.recentSearches.count - 1 - indexPath.row

        cell.configure(with: UserDefaultManager.recentSearches[reversedIndexPathRow][0])

        return cell
    }
}


