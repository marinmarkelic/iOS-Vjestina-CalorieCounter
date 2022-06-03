//import UIKit
//import PNChartSwift
//
//class ProgressPieChartThree: UIView{
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setBarChart() -> PNBarChart {
//            let barChart = PNBarChart(frame: CGRect(x: 0, y: 135, width: 320, height: 200))
//            barChart.backgroundColor = UIColor.clear
//            barChart.animationType = .Waterfall
//            barChart.labelMarginTop = 5.0
//            barChart.xLabels = ["Sep 1", "Sep 2", "Sep 3", "Sep 4", "Sep 5", "Sep 6", "Sep 7"]
//            barChart.yValues = [1, 23, 12, 18, 30, 12, 21]
//            barChart.strokeChart()
//            barChart.center = self.view.center
//            return barChart
//        }
//}
