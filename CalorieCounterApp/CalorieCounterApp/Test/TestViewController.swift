import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    var pieChart: CustomPieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        view.backgroundColor = .white
        
        pieChart = CustomPieChartView()
        configurePieChart()
        
        
        view.addSubview(pieChart)
    }
    
    func configurePieChart(){
        pieChart.customizeChart(dataPoints: eggNutrients, values: eggNutrientsValues.map( {Double($0)} ))
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightPerTapEnabled = false
        
        pieChart.drawCenterTextEnabled = true
        pieChart.centerText = "Nutrition values"
        
        
        let l = pieChart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.orientation = .vertical
        l.verticalAlignment = .center
    }
    
    func addConstraints(){
        pieChart.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

