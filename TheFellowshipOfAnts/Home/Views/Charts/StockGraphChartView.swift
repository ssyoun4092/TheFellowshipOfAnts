//
//  StockGraphChartView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit

import Charts
import SnapKit

class StockGraphChartView: UIView {

    // MARK: - IBOutlet

    let lineChartView = LineChartView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLineChartView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with values: [Double], upDown: UpDown) {
        var entries = [ChartDataEntry]()

        for (index, value) in values.enumerated() {
            let value = ChartDataEntry(x: Double(index), y: value)
            entries.append(value)
        }

        let dataSet = LineChartDataSet(entries: entries, label: "1day")

        dataSet.colors = [upDown.textColor]
        dataSet.drawFilledEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 4

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
    }
}

extension StockGraphChartView {
    private func setupLineChartView() {
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
