import UIKit

import SnapKit

final class StockRankSectionView: UIView {

    // MARK: - IBOutlets

    let titleLabel = UILabel()
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    )
    let collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
            group.interItemSpacing = .fixed(28)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 15
            let trailingSpacing = UIScreen.main.bounds.width * 0.1
            section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: trailingSpacing)
            section.orthogonalScrollingBehavior = .groupPaging

            return section
        }

        return layout
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTitleLabel()
        setupStocksCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StockRankSectionView {
    func setupTitleLabel() {
        addSubview(titleLabel)

        titleLabel.text = "TOP 20"
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)


        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
    }

    func setupStocksCollectionView() {
        addSubview(collectionView)

        collectionView.register(
            StockRankCollectionViewCell.self,
            forCellWithReuseIdentifier: StockRankCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.tag = 1

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(400)
            $0.bottom.equalToSuperview()
        }
    }
}
