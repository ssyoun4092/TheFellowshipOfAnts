import UIKit
import SnapKit

class MajorCommoditiesSectionView: UIView {
    let descriptions: [String] = ["금", "원유", "니켈", "옥수수"]

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주요 원자재 가격"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MajorCommodityCollectionViewCell.self, forCellWithReuseIdentifier: "MajorCommodityCollectionViewCell")
        collectionView.isPagingEnabled = true
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

        return layout
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutIfNeeded() {
        let segmentSize = descriptions.count
        collectionView.scrollToItem(at: IndexPath(item: segmentSize, section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
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

        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MajorCommodityCollectionViewCell", for: indexPath) as? MajorCommodityCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .lightGray.withAlphaComponent(0.5)
        cell.configure(description: descriptions[indexPath.row])

        return cell
    }
}

extension MajorCommoditiesSectionView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cellWidth = (UIScreen.main.bounds.width - (2 * 20)) / 2.5
        let offsetX = Int(scrollView.contentOffset.x)
        let currentPage = offsetX / Int(cellWidth)
        let indexPath = collectionView.indexPathsForVisibleItems[0]

        print("offsetX: \(offsetX)")
        print("currentPage: \(currentPage)")
        print("visibleIndexPath: \(indexPath)")
    }
}
