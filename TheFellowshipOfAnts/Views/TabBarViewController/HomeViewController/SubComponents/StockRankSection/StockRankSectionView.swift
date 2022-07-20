import UIKit
import SnapKit

final class StockRankSectionView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TOP 20"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)

        return label
    }()

//    private lazy var filterCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        return collectionView
//    }()

    private lazy var stocksCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(StockRankCollectionViewCell.self, forCellWithReuseIdentifier: "StockRankCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .gray
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 4)
            group.interItemSpacing = .fixed(5)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 15
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous

            return section

//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .fractionalHeight(1))
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 4)
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPagingCentered
//
//            return section
        }

        return layout
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        [titleLabel, stocksCollectionView].forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        stocksCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(200)
        }
    }
}

extension StockRankSectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .purple
        cell.setupUI()

        return cell
    }
}

extension StockRankSectionView: UICollectionViewDelegate {

}
