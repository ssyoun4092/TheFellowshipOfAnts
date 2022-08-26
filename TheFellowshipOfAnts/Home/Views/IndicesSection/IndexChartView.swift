import Foundation
import UIKit
import Charts
import SnapKit

class IndexChartView: UIView {

    // MARK: - IBOulet

    private let lineChartView = LineChartView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupChartView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func reset() {
        lineChartView.data = nil
    }

    /*
    func configure(with model: IndexChartInfo) {
        var entries = [ChartDataEntry]()

        for (index, value) in model.data.enumerated() {
            let value = ChartDataEntry(x: Double(index), y: value)
            entries.append(value)
        }
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false

        let gradient: [CGColor] = [UIColor.blue.cgColor, UIColor.brown.cgColor]
        let dataSet = LineChartDataSet(entries: entries, label: "1day")
        dataSet.colors = [UIColor.red]
        dataSet.fill = LinearGradientFill(gradient: CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradient as CFArray, locations: [0.0, 1.0])!, angle: -90)
        //        dataSet.fillColor = model.fillColor
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 3

        let data = LineChartData()
        data.append(dataSet)

        lineChartView.data = data
    }
    */
}

extension IndexChartView {
    private func setupChartView() {
        addSubview(lineChartView)

        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.setScaleEnabled(true)
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.isUserInteractionEnabled = false
        lineChartView.backgroundColor = .systemBlue

        lineChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
