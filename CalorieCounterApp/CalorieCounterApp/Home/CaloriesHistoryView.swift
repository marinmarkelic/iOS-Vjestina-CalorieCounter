import UIKit
import SnapKit

class CaloriesHistoryView: UIView{
    
    var mainView: UIView!
    
    var historyChart: CaloriesHistoryLineChart!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(dataPoints: [String], values: [Float]){
        historyChart.customizeChart(dataPoints: dataPoints, values: values)
        historyChart.notifyDataSetChanged()
        historyChart.animate(yAxisDuration: 0.5, easingOption: .linear)
    }
    
    func buildViews(){
        mainView = UIView()
//        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        
        historyChart = CaloriesHistoryLineChart()
        historyChart.animate(yAxisDuration: 0.5, easingOption: .linear)
        historyChart.xAxis.drawAxisLineEnabled = false
        historyChart.xAxis.drawGridLinesEnabled = false
        historyChart.leftAxis.drawAxisLineEnabled = false
        historyChart.rightAxis.enabled = false
//        historyChart.maxVisibleCount = 7
        historyChart.legend.enabled = false

        
        addSubview(mainView)
        addSubview(historyChart)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        historyChart.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
