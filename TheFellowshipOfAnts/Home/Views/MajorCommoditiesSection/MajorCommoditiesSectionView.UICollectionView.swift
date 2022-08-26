//
//  MajorCommoditiesSectionView.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/26.
//

import UIKit

extension MajorCommoditiesSectionView: UICollectionViewDataSource {
    var descriptions: [String] { return ["금", "원유", "니켈", "옥수수", "은", "카카오"] }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return descriptions.count * 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MajorCarouselCell.identifier,
            for: indexPath) as? MajorCarouselCell else { return UICollectionViewCell() }
        let itemIndex = indexPath.row % descriptions.count

        cell.configure(description: descriptions[itemIndex])

        return cell
    }
}

extension MajorCommoditiesSectionView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidth = layout.itemSize.width
        let spacing = layout.minimumLineSpacing
        let cellWidthIncludingSpacing = cellWidth + spacing

        let offset = scrollView.contentOffset.x
        let estimatedIndex = offset / cellWidthIncludingSpacing

        let index: Int

        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }

        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing + ((cellWidth / 4) * 0.75), y: 0)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var item = collectionView.indexPathsForVisibleItems[0].item
        print(collectionView.indexPathsForVisibleItems)
        if item == 1 {
            item = descriptions.count + 2
            collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: false)
        } else if item == descriptions.count * 3 - 4 {
            item = descriptions.count + 3
            collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}
