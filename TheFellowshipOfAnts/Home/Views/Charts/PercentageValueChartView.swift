//
//  GrossProfitRatioChartView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/05.
//

import UIKit

import Charts
import SnapKit

class PercentageValueBarChartView: UIView {

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

extension PercentageValueBarChartView {
    private func setupBarChartView() {
        addSubview(barChartView)

        barChartView.xAxis.axisLineColor = .clear
        barChartView.xAxis.gridColor = .clear
        barChartView.xAxis.labelFont = .systemFont(ofSize: 15, weight: .bold)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 1
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

extension PercentageValueBarChartView: ValueFormatter {
    func stringForValue(
        _ value: Double,
        entry: ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: ViewPortHandler?
    ) -> String {

        return String((value * 100).toStringWithFloor(at: 1)) + "%"
    }
}
