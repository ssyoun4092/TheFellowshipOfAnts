//
//  StockDetailViewController.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/09.
//

import UIKit

extension StockDetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        print("overviews: \(overviews)")

        return overviews.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let titles: [String] = ["시가 총액", "52주 최고가", "52주 최저가", "PER", "PBR", "EPS"]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockOverviewCollectionViewCell.identifier, for: indexPath) as? StockOverviewCollectionViewCell else { return UICollectionViewCell() }
        let title = titles[indexPath.row]
        let value = overviews[indexPath.row]
        cell.configure(with: title, value: value)

        return cell
    }
}
