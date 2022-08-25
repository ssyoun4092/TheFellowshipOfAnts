import UIKit
import SnapKit

class RecentSearchListView: UIView {
    let dummyList: [String] = [
        "에코프로비엠",
        "엘엔에프",
        "애플",
        "알파벳"
    ]

    private lazy var recentSearchTitle: UILabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.font = .systemFont(ofSize: 17, weight: .semibold)

        return label
    }()

    private lazy var deleteAllSearchesLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 삭제"
        label.font = .systemFont(ofSize: 15, weight: .regular)

        return label
    }()

    private lazy var recentSearchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(RecentSearchCell.self, forCellWithReuseIdentifier: RecentSearchCell.identifer)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)

        return layout
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentSearchListView {
    private func layout() {
        addSubviews([recentSearchTitle, deleteAllSearchesLabel, recentSearchCollectionView])

        recentSearchTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }

        deleteAllSearchesLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(recentSearchTitle.snp.bottom).inset(2)
        }

        recentSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitle.snp.bottom).offset(5)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCell.identifer, for: indexPath) as? RecentSearchCell else { return UICollectionViewCell() }
        cell.configure(item: dummyList[indexPath.row])
        cell.backgroundColor = .lightGray

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
