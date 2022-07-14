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
    /*
 {
     "datetime": "2022-06-23",
     "open": "11137.67969",
     "high": "11260.26953",
     "low": "11046.28027",
     "close": "11232.19043",
     "volume": "5238210000"
 },
 {
     "datetime": "2022-06-22",
     "open": "10941.95020",
     "high": "11216.76953",
     "low": "10938.05957",
     "close": "11053.08008",
     "volume": "5215100000"
 },
 {
     "datetime": "2022-06-21",
     "open": "10974.04980",
     "high": "11164.99023",
     "low": "10974.04980",
     "close": "11069.29980",
     "volume": "5201450000"
 },
 {
     "datetime": "2022-06-17",
     "open": "10697.54980",
     "high": "10884.70996",
     "low": "10638.71973",
     "close": "10798.34961",
     "volume": "7423600000"
 },
 {
     "datetime": "2022-06-16",
     "open": "10806.01953",
     "high": "10831.07031",
     "low": "10565.13965",
     "close": "10646.09961",
     "volume": "5667810000"
 },
 {
     "datetime": "2022-06-15",
     "open": "10968.40039",
     "high": "11244.25977",
     "low": "10866.38965",
     "close": "11099.15039",
     "volume": "5346110000"
 },
 {
     "datetime": "2022-06-14",
     "open": "10897.42969",
     "high": "10926.80957",
     "low": "10733.04004",
     "close": "10828.34961",
     "volume": "4802090000"
 },
 {
     "datetime": "2022-06-13",
     "open": "10986.84961",
     "high": "11071.48047",
     "low": "10775.13965",
     "close": "10809.23047",
     "volume": "5912360000"
 },
 {
     "datetime": "2022-06-10",
     "open": "11543.87988",
     "high": "11569.15039",
     "low": "11328.26953",
     "close": "11340.01953",
     "volume": "5125980000"
 },
 {
     "datetime": "2022-06-09",
     "open": "12016.46973",
     "high": "12115.05957",
     "low": "11751.98047",
     "close": "11754.23047",
     "volume": "5382110000"
 },
 {
     "datetime": "2022-06-08",
     "open": "12147.28027",
     "high": "12235.78027",
     "low": "12052.70020",
     "close": "12086.26953",
     "volume": "4689310000"
 },
 {
     "datetime": "2022-06-07",
     "open": "11925.80957",
     "high": "12194.86035",
     "low": "11888.61035",
     "close": "12175.23047",
     "volume": "4383960000"
 },
 {
     "datetime": "2022-06-06",
     "open": "12200.33008",
     "high": "12245.40039",
     "low": "12004.20020",
     "close": "12061.37012",
     "volume": "4633950000"
 },
 {
     "datetime": "2022-06-03",
     "open": "12097.12012",
     "high": "12167.44043",
     "low": "11966.62012",
     "close": "12012.73047",
     "volume": "4117290000"
 },
 {
     "datetime": "2022-06-02",
     "open": "11945.57031",
     "high": "12320.12012",
     "low": "11901.45020",
     "close": "12316.90039",
     "volume": "4422830000"
 },
 {
     "datetime": "2022-06-01",
     "open": "12176.88965",
     "high": "12237.94043",
     "low": "11901.42969",
     "close": "11994.45996",
     "volume": "4697810000"
 }*/
    let sections: [Section] = [
        MarketIndexSection(viewModel: nil)
    ]

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: colleectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MarketIndexCollectionViewCell.self, forCellWithReuseIdentifier: "MarketIndexCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    lazy var colleectionViewLayout: UICollectionViewLayout = {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketIndexCollectionViewCell", for: indexPath) as? MarketIndexCollectionViewCell else { return UICollectionViewCell() }
        let model = dummyModel[indexPath.row]
        let data = dummyModel.map { $0.close }.map { Double($0)! }
        cell.configure(with: .init(
            indexName: "Nasdaq",
            currentPrice: "111000",
            priceUpDown: "1.58%",
            chartViewModel: .init(data: data))
        )
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {

}

struct HomeViewControllerPreView: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
