import Foundation
import UIKit

struct StockRankSection: Section {
    let numberOfItems: Int = 20
    let viewModel: [MarketInfoModel]?

    func layout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        group.interItemSpacing = .fixed(5)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MarketIndexCell.self), for: indexPath) as? MarketIndexCell else { return UICollectionViewCell() }
        if let viewModel = viewModel {
            cell.configure(with: viewModel[indexPath.row] as! MarketIndexCell.MarketIndexInfoModel)
        }
        return cell
    }
}
