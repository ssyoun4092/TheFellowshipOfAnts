import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let indexList: [String] = ["IXIC", "DJI", "SPX"]
    var marketIndices = [IndicesModel]()
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
        fetchMarketIndex()
    }

    func configCollectionView() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func fetchMarketIndex() {
        indexList.forEach { index in
            guard let url = URL(string: "https://api.twelvedata.com/time_series?symbol=\(index)&interval=1day&apikey=f2686fc884eb45b9b6e854b74f04e80e") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil,
                      let index = try? JSONDecoder().decode(IndicesModel.self, from: data)
                    else {
                    print("ERROR: \(error?.localizedDescription)")
                    return }

                switch response.statusCode {
                case (200...299):
                    self?.marketIndices.append(index)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    print(self?.marketIndices)
                default:
                    print("ERROR HAPPENED")
                }
            }
            dataTask.resume()
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketIndexCell", for: indexPath) as? MarketIndexCell
            else { return UICollectionViewCell() }

            if marketIndices.count == 3 {
                let currentPrices = marketIndices.map { model in
                    model.values[0].close
                }

                let pricesUpDown = marketIndices.map { model -> String in
                    let firstDayPrice = Double(model.values[0].close)!
                    let secondDayPrice = Double(model.values[1].close)!
                    var fluctuation = (((firstDayPrice - secondDayPrice) / firstDayPrice) * 100)
                    fluctuation = round(fluctuation * 100)
                    fluctuation = fluctuation / 100
                    return String(fluctuation) + "%"
                }

                let datas = marketIndices.map { model in
                    model.values.map { Double($0.close)! }
                }

                cell.configure(with: .init(
                    indexName: indexList[indexPath.row],
                    currentPrice: currentPrices[indexPath.row],
                    priceUpDown: pricesUpDown[indexPath.row],
                    updown: .up,
                    chartViewModel: .init(data: datas[indexPath.row])))
            } else {
                print("market Indices")
            }

            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCell", for: indexPath) as? StockRankCell else
            { return UICollectionViewCell() }

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
