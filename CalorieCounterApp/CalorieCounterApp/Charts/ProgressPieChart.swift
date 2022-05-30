import Charts
import UIKit

class ProgressPieChart: PieChartView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
//        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        pieChartDataSet.colors = [.red, .lightGray]
//        pieChartDataSet.yValuePosition = .outsideSlice
//        pieChartDataSet.valueTextColor = .black
        pieChartDataSet.drawValuesEnabled = false
        setExtraOffsets(left: -10, top: -10, right: -10, bottom: -10)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 2
        format.multiplier = 1.0
        format.percentSymbol = "%"
        format.zeroSymbol = ""
        let formatter = DefaultValueFormatter(formatter: format)
       
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        data = pieChartData
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
