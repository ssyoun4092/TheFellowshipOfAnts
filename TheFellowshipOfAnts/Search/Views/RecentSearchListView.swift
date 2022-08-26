import UIKit
import SnapKit

class RecentSearchListView: UIView {
    let dummyList: [String] = [
        "에코프로비엠",
        "엘엔에프",
        "애플",
        "알파벳"
    ]

    // MARK: - IBOulets

    let recentSearchTitleLabel = UILabel()
    let deleteAllLabel = UILabel()
    lazy var recentSearchCollectionView = UICollectionView(
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
        setupDeleteAllLabel()
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

    private func setupDeleteAllLabel() {
        addSubview(deleteAllLabel)

        deleteAllLabel.text = "전체 삭제"
        deleteAllLabel.font = .systemFont(ofSize: 15, weight: .regular)

        deleteAllLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(trailing)
            $0.bottom.equalTo(recentSearchTitleLabel.snp.bottom).inset(2)
        }
    }

    private func setupRecentSearchCollectionView() {
        addSubview(recentSearchCollectionView)

        recentSearchCollectionView.register(
            RecentSearchCell.self,
            forCellWithReuseIdentifier: RecentSearchCell.identifier)
        recentSearchCollectionView.showsHorizontalScrollIndicator = false
        recentSearchCollectionView.dataSource = self
        recentSearchCollectionView.delegate = self

        recentSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
}

extension RecentSearchListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dummyList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCell.identifier, for: indexPath) as? RecentSearchCell else { return UICollectionViewCell() }

        cell.configure(with: dummyList[indexPath.row])

        return cell
    }
}

extension RecentSearchListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = dummyList[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)]).width
        let xWidth = "X".size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]).width
        let inset = CGFloat(15)
        let spacing = CGFloat(13)
        let totalWidth = itemWidth + xWidth + (2 * inset) + spacing

        return CGSize(width: totalWidth, height: 30)
    }
}
