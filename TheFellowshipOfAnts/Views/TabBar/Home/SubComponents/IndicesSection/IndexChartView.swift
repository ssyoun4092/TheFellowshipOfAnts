import Foundation
import UIKit
import Charts
import SnapKit

class IndexChartView: UIView {
    private let lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.drawGridBackgroundEnabled = false
        chartView.isUserInteractionEnabled = false
        chartView.backgroundColor = .systemBlue
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineChartView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        lineChartView.frame = bounds
    }

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
