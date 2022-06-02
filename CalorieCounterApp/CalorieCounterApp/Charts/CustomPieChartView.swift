import Charts
import UIKit

class CustomPieChartView: PieChartView{
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
        pieChartDataSet.colors = colorsOfCharts(dataPoints: dataPoints)
//        pieChartDataSet.yValuePosition = .outsideSlice
//        pieChartDataSet.valueTextColor = .black
        pieChartDataSet.drawValuesEnabled = false
        
        
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
    
    private func colorsOfCharts(dataPoints: [String]) -> [UIColor] {
        var colors: [UIColor] = []
        for dp in dataPoints {
            colors.append(chooseColor(name: dp))
        }
        return colors
    }
    
}
