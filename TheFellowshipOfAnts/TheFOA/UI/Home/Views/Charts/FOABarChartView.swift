//
//  BarChartView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/31.
//

import UIKit

import Charts
import SnapKit

class FOABarChartView: UIView {

    // MARK: - Properties
    enum BarChartType {
        case absolute
        case percentage
    }

    private let chartType: BarChartType

    init(chartType: BarChartType) {
        self.chartType = chartType
        super.init(frame: .zero)

        setupBarChartView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let barChartView: BarChartView = {
        let chart = BarChartView()
        chart.xAxis.axisLineColor = .clear
        chart.xAxis.gridColor = .clear
        chart.xAxis.labelFont = .systemFont(ofSize: 15, weight: .bold)
        chart.xAxis.labelPosition = .bottom

        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.resetCustomAxisMax()
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false

        chart.legend.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.drawBordersEnabled = false
        chart.isUserInteractionEnabled = false
        return chart
    }()

    func configure(with values: [Double], periods: [String]) {
//        var entries = [BarChartDataEntry]()
        print("values: \(values)")

//        for (index, value) in values.enumerated() {
//            let entryData = BarChartDataEntry(x: Double(index), y: value)
//            entries.append(entryData)
//        }

        let entries = (0..<values.count).map { index -> BarChartDataEntry in
            BarChartDataEntry(x: Double(index), y: values[index])
        }

        let chartDataSet = setupChartDataSet(entries: entries)
        for (index, entry) in chartDataSet.enumerated() {
            stringForValue(values[index], entry: entry, dataSetIndex: index, viewPortHandler: nil)
        }

        if let minimumValue = values.min(),
           minimumValue < 0 {
            barChartView.leftAxis.axisMinimum = minimumValue * 3
        }

        setupLeftAxisMaximum()
        barChartView.xAxis.setLabelCount(periods.count, force: false)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: periods)

        let data = BarChartData(dataSet: chartDataSet)
        barChartView.data = data
    }
}

extension FOABarChartView {
    private func setupBarChartView() {
        addSubview(barChartView)

        barChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupLeftAxisMaximum() {
        switch chartType {
        case .absolute: return barChartView.leftAxis.resetCustomAxisMax()
        case .percentage: return barChartView.leftAxis.axisMaximum = 1
        }
    }

    private func setupChartDataSet(entries: [BarChartDataEntry]) -> BarChartDataSet {
        let chartDataSet = BarChartDataSet(entries: entries)
        chartDataSet.colors = [.designSystem(.Purple) ?? .black]
        chartDataSet.valueFont = .systemFont(ofSize: 13, weight: .bold)
        chartDataSet.valueFormatter = self

        return chartDataSet
    }
}

extension FOABarChartView: ValueFormatter {
    func stringForValue(_ value: Double, entry: Charts.ChartDataEntry, dataSetIndex: Int, viewPortHandler: Charts.ViewPortHandler?) -> String {
        switch chartType {
        case .absolute: return value.asMetrics()
        case .percentage: return String((value * 100).toStringWithFloor(at: 1)) + "%"
        }
    }
}
