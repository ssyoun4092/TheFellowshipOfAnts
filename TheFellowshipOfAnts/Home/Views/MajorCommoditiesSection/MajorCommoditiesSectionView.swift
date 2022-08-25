import UIKit
import SnapKit

class MajorCommoditiesSectionView: UIView {
    private let descriptions: [String] = ["금", "원유", "니켈", "옥수수", "은", "카카오"]

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주요 원자재 가격"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MajorCommodityCollectionViewCell.self, forCellWithReuseIdentifier: "MajorCommodityCollectionViewCell")
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    private lazy var flowLayout: UICollectionViewLayout = {
        let spacing: CGFloat = 20
        let cellWidth = (UIScreen.main.bounds.width - (2 * spacing)) / 2.5

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: 120)
        layout.minimumLineSpacing = (spacing / 2)

        let sideSpacing = ((cellWidth * 3) + (2 * spacing) - UIScreen.main.bounds.width) / 2
        print(cellWidth / sideSpacing)

        return layout
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.scrollToItem(at: IndexPath(item: descriptions.count, section: 0), at: .centeredHorizontally, animated: false)
    }

    private func setupUI() {
        [titleLabel, collectionView]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MajorCommoditiesSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return descriptions.count * 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MajorCommodityCollectionViewCell", for: indexPath) as? MajorCommodityCollectionViewCell else { return UICollectionViewCell() }
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
