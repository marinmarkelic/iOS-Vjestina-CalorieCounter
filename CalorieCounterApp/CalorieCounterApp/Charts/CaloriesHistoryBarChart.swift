import UIKit
import Charts

class CaloriesHistoryBarChart: BarChartView, IAxisValueFormatter{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stringForValue(_ dataPointIndex: Double, axis: AxisBase?) -> String {
        return ""
    }
    
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
        // 1. Set ChartDataEntry
        var dataEntries: [BarChartDataEntry] = []
        var lineEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            let lineEntry = ChartDataEntry(x: Double(i), y: Double(2000))
            dataEntries.append(dataEntry)
            lineEntries.append(lineEntry)

        }
        
        legend.setCustom(entries: [])
        
        xAxis.drawLabelsEnabled = false
        
        let rightYAxis = getAxis(.right)
//        hides number values on right Y axis
        rightYAxis.valueFormatter = self
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Data")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let lineChartSet = LineChartDataSet(entries: lineEntries, label: "Line Data")
        let lineData = LineChartData(dataSet: lineChartSet)

        let combinedData: CombinedChartData = CombinedChartData(dataSets: [chartDataSet, lineChartSet])
        combinedData.barData = chartData
        combinedData.lineData = lineData
        
        data = combinedData
        data = chartData
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
}
