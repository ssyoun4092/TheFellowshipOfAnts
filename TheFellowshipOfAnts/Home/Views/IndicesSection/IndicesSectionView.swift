import UIKit
import SnapKit

final class IndicesSectionView: UIView {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(IndexCollectionViewCell.self, forCellWithReuseIdentifier: "IndexCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private lazy var flowLayout: UICollectionViewLayout = {
        let spacing: CGFloat = 30
        let cellWidth = UIScreen.main.bounds.width - (2 * spacing)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumLineSpacing = CGFloat(spacing * 2)

        return layout
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .systemRed.withAlphaComponent(0.3)
        pageControl.isUserInteractionEnabled = false

        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [collectionView, pageControl]
            .forEach { addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }


    }

    private func setupCollectionView() {
        addSubview(collectionView)

        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(IndexCollectionViewCell.self, forCellWithReuseIdentifier: "IndexCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
    }

    private func setupPageControl() {
        addSubview(pageControl)

        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .systemRed.withAlphaComponent(0.3)
        pageControl.isUserInteractionEnabled = false

        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension IndicesSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndexCollectionViewCell", for: indexPath) as? IndexCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }
}

extension IndicesSectionView: UICollectionViewDelegate {

}

extension IndicesSectionView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = UIScreen.main.bounds.width
        let currentPage = Int(offset / width)
        self.pageControl.currentPage = currentPage
    }
}
