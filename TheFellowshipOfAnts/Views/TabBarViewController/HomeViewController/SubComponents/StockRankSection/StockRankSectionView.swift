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
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
            group.interItemSpacing = .fixed(28)

            let section = NSCollectionLayoutSection(group: group)
            section.visibleItemsInvalidationHandler = { (items, point, env) in
                print(point.x)
            }
            section.interGroupSpacing = 15
            section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPaging

            return section
        }

        return layout
    }()

    private let dividerView = DividerView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        [titleLabel, stocksCollectionView, dividerView]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        stocksCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(400)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(stocksCollectionView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
            $0.bottom.equalToSuperview()
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
        let ranks = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(rank: ranks[indexPath.row])

        return cell
    }
}

extension StockRankSectionView: UICollectionViewDelegate {

}
