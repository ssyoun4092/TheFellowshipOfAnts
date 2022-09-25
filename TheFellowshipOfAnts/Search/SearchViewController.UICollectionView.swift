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

        return UserDefaultManager.shared.recentSearches.count
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
        let reversedIndexPathRow = UserDefaultManager.shared.recentSearches.count - 1 - indexPath.row

        cell.configure(with: UserDefaultManager.shared.recentSearches[reversedIndexPathRow][0])

        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let reversedIndexPathRow = UserDefaultManager.shared.recentSearches.count - 1 - indexPath.row

        let itemWidth = UserDefaultManager.shared.recentSearches[reversedIndexPathRow][0].size(
            withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 16,
                weight: .medium)]
        ).width

        let xWidth = "X".size(
            withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 14,
                weight: .regular)]
        ).width
        let inset = CGFloat(15)
        let spacing = CGFloat(13)
        let totalWidth = itemWidth + xWidth + (2 * inset) + spacing

        return CGSize(width: totalWidth, height: 30)
    }
}
