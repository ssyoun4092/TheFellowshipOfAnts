import UIKit
import SnapKit

class MajorETFSectionView: UIView {

    // MARK: - IBOulets

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
        setupColletionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.scrollToItem(
            at: IndexPath(item: descriptions.count, section: 0),
            at: .centeredHorizontally, animated: false)
    }
}

extension MajorETFSectionView {
    private func setupTitleLabel() {
        addSubview(titleLabel)

        titleLabel.text = "주요 ETF"
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
    }

    private func setupColletionView() {
        addSubview(collectionView)

        collectionView.register(
            MajorCarouselCell.self,
            forCellWithReuseIdentifier: MajorCarouselCell.identifier)
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview()
        }
    }
}


