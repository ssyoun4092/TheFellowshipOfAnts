import UIKit

import SnapKit

final class IndicesSectionView: UIView {

    // MARK: - Properties
    var stockIndexes: [StockIndex] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - IBOutlets
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout
    )
    let flowLayout: UICollectionViewLayout = {
        let spacing: CGFloat = 30
        let cellWidth = UIScreen.main.bounds.width - (2 * spacing)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumLineSpacing = CGFloat(spacing * 2)

        return layout
    }()
    let pageControl = UIPageControl()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
        setupPageControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IndicesSectionView {
    private func setupCollectionView() {
        addSubview(collectionView)

        collectionView.register(
            IndiceCollectionViewCell.self,
            forCellWithReuseIdentifier: IndiceCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = 0

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
    }

    private func setupPageControl() {
        addSubview(pageControl)

        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .systemPurple
        pageControl.pageIndicatorTintColor = .systemPurple.withAlphaComponent(0.3)
        pageControl.isUserInteractionEnabled = false

        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
