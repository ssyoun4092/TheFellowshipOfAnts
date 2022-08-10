import UIKit
import SnapKit

class MessagesView: UIView {
    private lazy var messageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MyMessageCell.self, forCellWithReuseIdentifier: MyMessageCell.identifer)
        collectionView.register(YourMessageCell.self, forCellWithReuseIdentifier: YourMessageCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var flowLayout: UICollectionViewLayout = {
        let cellWidth = UIScreen.main.bounds.width

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.minimumLineSpacing = 70
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: cellWidth, height: 900)

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

extension MessagesView {
    private func layout() {
        addSubview(messageCollectionView)

        messageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MessagesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let texts: [String] = [
            "안녕하세요",
            "안녕하세요",
            "안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요",
            "안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요"
        ]

        if (indexPath.row % 2 == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyMessageCell.identifer, for: indexPath) as! MyMessageCell
            cell.configure(text: texts[indexPath.row])

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YourMessageCell.identifier, for: indexPath) as! YourMessageCell
            cell.configure(text: texts[indexPath.row])

            return cell
        }
    }
}

extension MessagesView: UICollectionViewDelegateFlowLayout {

}
