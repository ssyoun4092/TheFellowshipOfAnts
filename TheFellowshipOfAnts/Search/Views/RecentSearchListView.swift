import UIKit

import SnapKit

class RecentSearchListView: UIView {

    // MARK: - IBOulets

    let recentSearchTitleLabel = UILabel()
    let deleteAllButton = UIButton()
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout
    )
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)

        return layout
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupRecentSearchTitleLabel()
        setupDeleteAllButton()
        setupRecentSearchCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentSearchListView {
    var leading: CGFloat { return 20 }
    var trailing: CGFloat { return 20 }

    private func setupRecentSearchTitleLabel() {
        addSubview(recentSearchTitleLabel)

        recentSearchTitleLabel.text = "최근 검색"
        recentSearchTitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        recentSearchTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(leading)
            $0.height.equalTo(20)
        }
    }

    private func setupDeleteAllButton() {
        addSubview(deleteAllButton)

        deleteAllButton.setTitle("전체 삭제", for: .normal)
        deleteAllButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        deleteAllButton.setTitleColor(.black, for: .normal)

        deleteAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(trailing)
            $0.bottom.equalTo(recentSearchTitleLabel.snp.bottom).inset(2)
        }
    }

    private func setupRecentSearchCollectionView() {
        addSubview(collectionView)

        collectionView.register(
            RecentSearchCell.self,
            forCellWithReuseIdentifier: RecentSearchCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
}
