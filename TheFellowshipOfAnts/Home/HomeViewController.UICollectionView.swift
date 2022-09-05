//
//  HomeViewController.UICollectionView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/31.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
    var majorCommodityList: [String] {
        return ["금", "원유", "니켈", "옥수수", "은", "카카오"]
    }

    var majorETFList: [String] {
        return ["SPY", "TLT", "SHY", "VIX"]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return stockIndexes.count
        case 1:
            return stockRanks.count
        case 2:
            return commodities.count * 3
        case 3:
            return etfs.count * 3
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndexCollectionViewCell.identifier, for: indexPath) as? IndexCollectionViewCell else { return UICollectionViewCell() }
            let stockIndex = stockIndexes[indexPath.row]
            let currentPrice = stockIndex.details.first?.close ?? "0"
            let prevPrice = stockIndex.details.last?.close ?? "0"

            let updown = UpDown.check(Double(prevPrice)!, Double(currentPrice)!)

            cell.configure(with: stockIndex, upDown: updown)

            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockRankCollectionViewCell.identifier, for: indexPath) as? StockRankCollectionViewCell else { return UICollectionViewCell() }
            let stockRank = stockRanks[indexPath.row]

            cell.configure(with: stockRank)

            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MajorCarouselCell.identifier,
                for: indexPath) as? MajorCarouselCell else { return UICollectionViewCell() }
            let itemIndex = indexPath.row % commodities.count

            cell.configure(with: commodities[itemIndex])

            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MajorCarouselCell.identifier,
                for: indexPath) as? MajorCarouselCell else { return UICollectionViewCell() }
            let itemIndex = indexPath.row % etfs.count
            
            cell.configure(with: etfs[itemIndex])

            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            let companyName = stockRanks[indexPath.row].companyName
            let symbol = stockRanks[indexPath.row].symbol
            coordinator?.pushToStockDetailViewController(companyName: companyName, symbol: symbol)
        default:
            print(#function)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView.tag {
        case 0:
            let offset = scrollView.contentOffset.x
            let width = UIScreen.main.bounds.width
            let currentPage = Int(offset / width)
            homeView.indicesSectionView.pageControl.currentPage = currentPage
        case 2:
            let collectionView = homeView.majorCommoditiesSectionView.collectionView
            var item = collectionView.indexPathsForVisibleItems[0].item
            if item == 1 {
                item = commodities.count + 2
                collectionView.scrollToItem(
                    at: IndexPath(item: item, section: 0),
                    at: .centeredHorizontally, animated: false
                )
            } else if item == commodities.count * 3 - 4 {
                item = commodities.count + 3
                collectionView.scrollToItem(
                    at: IndexPath(item: item, section: 0),
                    at: .centeredHorizontally, animated: false
                )
            }
        case 3:
            let collectionView = homeView.majorETFSectionView.collectionView
            var item = collectionView.indexPathsForVisibleItems[0].item
            if item == 1 {
                item = etfs.count + 2
                collectionView.scrollToItem(
                    at: IndexPath(item: item, section: 0),
                    at: .centeredHorizontally, animated: false
                )
            } else if item == etfs.count * 3 - 4 {
                item = etfs.count + 3
                collectionView.scrollToItem(
                    at: IndexPath(item: item, section: 0),
                    at: .centeredHorizontally, animated: false
                )
            }
        default:
            print(#function)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        switch scrollView.tag {
        case 2:
            guard let layout = homeView.majorCommoditiesSectionView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
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
        case 3:
            guard let layout = homeView.majorETFSectionView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
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
        default:
            print(#function)
        }
    }
}
