import UIKit
import SwiftUI
import SnapKit

class HomeViewController: UIViewController {
    let dummyModel: [Value] = [
        Value(datetime: "2022-07-14", valueOpen: "11151.20801", high: "11163.31934", low: "11006.68945", close: "11025.60840", volume: "597308402"),
        Value(datetime: "2022-07-13", valueOpen: "11056.54980", high: "11325.66992", low: "11031.26953", close: "11247.58008", volume: "4400730000"),
        Value(datetime: "2022-07-12", valueOpen: "11420.88965", high: "11483.16992", low: "11207.08008", close: "11264.73047", volume: "4279920000"),
        Value(datetime: "2022-07-11", valueOpen: "11524.49023", high: "11541.09961", low: "11348.05957", close: "11372.59961", volume: "4343130000"),
        Value(datetime: "2022-07-08", valueOpen: "11503.61035", high: "11689.70020", low: "11479.76953", close: "11635.30957", volume: "4495900000"),
        Value(datetime: "2022-07-07", valueOpen: "11422.59961", high: "11644.46973", low: "11412.87988", close: "11621.34961", volume: "4662320000"),
        Value(datetime: "2022-07-06", valueOpen: "11337.90039", high: "11443.15039", low: "11250.32031", close: "11621.34961", volume: "4824620000"),
        Value(datetime: "2022-07-05", valueOpen: "10964.17969", high: "11323.88965", low: "10911.45020", close: "11322.24023", volume: "5028520000"),
        Value(datetime: "2022-07-01", valueOpen: "11006.83008", high: "11132.54980", low: "10922.70996", close: "11127.84961", volume: "4844560000"),
        Value(datetime: "2022-06-30", valueOpen: "11048.25000", high: "11160.91992", low: "10850.00977", close: "11028.74023", volume: "5620800000"),
        Value(datetime: "2022-06-29", valueOpen: "11160.21973", high: "11226.33008", low: "11072.19043", close: "11177.88965", volume: "5609230000"),
        Value(datetime: "2022-06-28", valueOpen: "11542.24023", high: "11635.84961", low: "11177.67969", close: "11181.54004", volume: "5397910000"),
        Value(datetime: "2022-06-27", valueOpen: "11661.01953", high: "11677.49023", low: "11487.07031", close: "11524.54980", volume: "5017930000"),
        Value(datetime: "2022-06-24", valueOpen: "11351.30957", high: "11613.23047", low: "11337.78027", close: "11607.62012", volume: "9438810000"),
        Value(datetime: "2022-06-23", valueOpen: "11137.67969", high: "11260.26953", low: "11046.28027", close: "11232.19043", volume: "5238210000")
    ]

    let sections: [Section] = [
        MarketIndexSection(viewModel: nil),
        StockRankSection(viewModel: nil)
    ]

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: colleectionViewLayout
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MarketIndexCell.self, forCellWithReuseIdentifier: "MarketIndexCell")
        collectionView.register(StockRankCell.self, forCellWithReuseIdentifier: "StockRankCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var colleectionViewLayout: UICollectionViewLayout = {
        let sections = self.sections
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _  -> NSCollectionLayoutSection? in
            sections[sectionIndex].layout()
        }
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        configCollectionView()
    }

    func configCollectionView() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketIndexCell", for: indexPath) as? MarketIndexCell else { return UICollectionViewCell() }
            let data = dummyModel.map { $0.close }.map { Double($0)! }
            cell.configure(with: .init(
                indexName: "Nasdaq",
                currentPrice: "111000",
                priceUpDown: "1.58%",
                updown: .up,
                chartViewModel: .init(data: data))
            )
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCell", for: indexPath) as? StockRankCell else { return UICollectionViewCell() }

            return cell
        default:
            print("None")
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {

}

struct HomeViewControllerPreView: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
