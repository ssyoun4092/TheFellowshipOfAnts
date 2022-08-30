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
        configure(with: dummy.chart30min.reversed(), upDown: .down)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func reset() {
        lineChartView.data = nil
    }

    func configure(with model: [Double], upDown: UpDown) {
        var entries = [ChartDataEntry]()

        for (index, value) in model.enumerated() {
            let value = ChartDataEntry(x: Double(index), y: value)
            entries.append(value)
        }

        let dataSet = LineChartDataSet(entries: entries, label: "1day")

        dataSet.colors = [upDown.textColor]
        let gradient = upDown.gradient
        dataSet.fill = Fill.fillWithLinearGradient(
            CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: gradient as CFArray,
                locations: [0.0, 1.0])!,
            angle: -90
        )
        dataSet.drawFilledEnabled = true
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
    }
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

        lineChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
