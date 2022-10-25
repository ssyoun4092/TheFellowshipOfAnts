//
//  ReveneueChartView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/04.
//

import UIKit

import Charts
import SnapKit

class AbsoluteValueBarChartView: UIView {

    // MARK: - Properties

    // MARK: - IBOutlets

    let barChartView = BarChartView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBarChartView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with values: [Double], periods: [String]) {
//        let annual: [String] = ["18", "19", "20", "21"]
//        let revenue: [String] = ["53.2", "53.8", "59.6", "81.4"]

        var entries = [BarChartDataEntry]()

        for (index, value) in values.enumerated() {
            let entryData = BarChartDataEntry(x: Double(index), y: value)
            entries.append(entryData)
        }

        let chartDataSet = BarChartDataSet(entries: entries)
        chartDataSet.colors = [.red]
        chartDataSet.valueFont = .systemFont(ofSize: 13, weight: .bold)
        chartDataSet.valueFormatter = self
        for (index, entry) in chartDataSet.enumerated() {
            stringForValue(values[index], entry: entry, dataSetIndex: index, viewPortHandler: nil)
        }

        barChartView.xAxis.setLabelCount(periods.count, force: false)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: periods)


        let data = BarChartData(dataSet: chartDataSet)
        barChartView.data = data
    }
}

extension AbsoluteValueBarChartView {
    private func setupBarChartView() {
        addSubview(barChartView)

        barChartView.xAxis.axisLineColor = .clear
        barChartView.xAxis.gridColor = .clear
        barChartView.xAxis.labelFont = .systemFont(ofSize: 15, weight: .bold)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.drawBordersEnabled = false
        barChartView.isUserInteractionEnabled = false

        barChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AbsoluteValueBarChartView: ValueFormatter {
    func stringForValue(
        _ value: Double,
        entry: ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: ViewPortHandler?
    ) -> String {

        return value.convertToMetrics()
    }
}