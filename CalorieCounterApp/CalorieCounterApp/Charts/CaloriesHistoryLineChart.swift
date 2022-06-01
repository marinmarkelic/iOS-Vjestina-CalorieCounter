import UIKit
import Charts

class CaloriesHistoryLineChart: LineChartView, IAxisValueFormatter{
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        return String(value == 1 ? 1 : 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func customizeChart(dataPoints: [String], values: [Float]) {
        
        xAxis.valueFormatter = self
        xAxis.labelPosition = .bottom
        xAxis.granularity = 0.1
//        xAxis.setLabelCount(7, force: true)
      
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(dataPoints[i].split(separator: "/")[2]) ?? 0, y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartData.setValueTextColor(.white)
        
        
        
//        let formatter = IValueFormatter()
//        formatter.
//
//        lineChartData.setValueFormatter(<#T##formatter: IValueFormatter##IValueFormatter#>)
        
        data = lineChartData
        setScaleEnabled(false);
        
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
