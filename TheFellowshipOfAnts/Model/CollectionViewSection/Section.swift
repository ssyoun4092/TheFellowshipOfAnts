import Foundation
import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func layout() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol MarketInfoModel {

}
