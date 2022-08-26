//
//  StockRankSection.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit

extension StockRankSectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ranks = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockRankCollectionViewCell.identifier, for: indexPath) as? StockRankCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: ranks[indexPath.row])

        return cell
    }
}

extension StockRankSectionView: UICollectionViewDelegate {

}
