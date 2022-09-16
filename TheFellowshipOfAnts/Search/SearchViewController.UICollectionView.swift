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

        return recentSearchList.count
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

        cell.configure(with: recentSearchList[indexPath.row])

        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemWidth = recentSearchList[indexPath.item].size(
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
