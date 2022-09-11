import UIKit

import SnapKit

class MajorCommoditiesSectionView: UIView {

    // MARK: - Properties
    let majorCommodityList: [String] = ["금", "원유", "니켈", "옥수수", "은", "카카오"]

    // MARK: - IBOutlets

    let titleLabel = UILabel()
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout
    )
    let flowLayout: UICollectionViewLayout = {
        let spacing: CGFloat = 20
        let cellWidth = (UIScreen.main.bounds.width - (2 * spacing)) / 2.5

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: 120)
        layout.minimumLineSpacing = (spacing / 2)

        let sideSpacing = ((cellWidth * 3) + (2 * spacing) - UIScreen.main.bounds.width) / 2

        return layout
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleLabel()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.scrollToItem(
            at: IndexPath(item: majorCommodityList.count, section: 0),
            at: .centeredHorizontally, animated: false)
    }
}

extension MajorCommoditiesSectionView {
    private func setupTitleLabel() {
        addSubview(titleLabel)

        titleLabel.text = "주요 원자재 가격"
        titleLabel.font = .systemFont(ofSize: 23, weight: .bold)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
    }

    private func setupCollectionView() {
        addSubview(collectionView)

        collectionView.register(
            MajorCarouselCell.self,
            forCellWithReuseIdentifier: MajorCarouselCell.identifier)
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        collectionView.tag = 2
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview()
        }
    }
}
