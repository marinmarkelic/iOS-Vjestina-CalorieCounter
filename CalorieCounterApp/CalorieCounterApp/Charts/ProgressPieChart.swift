import Charts
import UIKit

class ProgressPieChart: PieChartView{
    var mainColor: UIColor = .clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
//        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        pieChartDataSet.colors = [mainColor, .clear]
//        pieChartDataSet.yValuePosition = .outsideSlice
//        pieChartDataSet.valueTextColor = .black
        pieChartDataSet.drawValuesEnabled = false
        setExtraOffsets(left: -10, top: -10, right: -10, bottom: -10)
        
        
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
    
    func setColor(color: UIColor){
        mainColor = color
    }    
}
