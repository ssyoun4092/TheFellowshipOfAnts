//
//  IndicesSectionView.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import Foundation
import UIKit

extension IndicesSectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return stockIndexes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndexCollectionViewCell.identifier, for: indexPath) as? IndexCollectionViewCell else { return UICollectionViewCell() }
        let stockIndex = stockIndexes[indexPath.row]
        let updown = UpDown.checkUpDown(Double(stockIndex.values[1].close)!, Double(stockIndex.values[0].close)!)
        cell.configure(with: stockIndex, upDown: updown)

        return cell
    }
}

extension IndicesSectionView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = UIScreen.main.bounds.width
        let currentPage = Int(offset / width)
        self.pageControl.currentPage = currentPage
    }
}
