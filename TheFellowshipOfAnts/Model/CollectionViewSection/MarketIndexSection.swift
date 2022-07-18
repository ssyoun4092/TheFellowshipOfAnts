import Foundation
import UIKit

struct MarketIndexSection: Section {
    let numberOfItems: Int = 3
    let viewModel: [MarketInfoModel]?

    func layout() -> NSCollectionLayoutSection {
        let spacing = (UIScreen.main.bounds.width * 0.15) / 2

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing / 2, bottom: 0, trailing: spacing / 2)
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
