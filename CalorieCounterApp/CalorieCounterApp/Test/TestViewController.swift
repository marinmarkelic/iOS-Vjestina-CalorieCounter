import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    var mainView = UIView()
    var pieChart: CustomPieChartView!
    var progressPieChart: ProgressPieChart!
    var chc: CaloriesHistoryBarChart!

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
        mainView = UIView()
        mainView.backgroundColor = .white
        
        pieChart = CustomPieChartView()
        configurePieChart()
        
        progressPieChart = ProgressPieChart()
        
        chc = CaloriesHistoryBarChart()
        
        NutritionRepository().loadNutritionData(itemDescription: "carrot"){
            self.pieChart.customizeChart(dataPoints: $0.getArrayOfNamesForGrams(), values: $0.getArrayOfValuesForGrams().map( {Double($0)} ))
        }
        
        chc.customizeChart(dataPoints: mockHistoryNames, values: mockHistoryValues)
        
        view.addSubview(mainView)
        mainView.addSubview(pieChart)
        mainView.addSubview(progressPieChart)
        mainView.addSubview(chc)
    }
    
    func configureProgressPieChart(){
//        progressPieChart.customizeChart(dataPoints: ["done", "remaining"], values: [1000.0, 250.0])
        progressPieChart.customizeChart(dataPoints: ["done", "remaining"], values: [Double(1000.0), Double(getMockBMR() - 1000)])
        progressPieChart.drawEntryLabelsEnabled = false
        progressPieChart.isUserInteractionEnabled = false
        progressPieChart.legend.enabled = false
        progressPieChart.holeRadiusPercent = 0.85
        progressPieChart.centerText = "\(Int(250.0/1000.0 * 100))%"
    }
    
    func configurePieChart(){
//        pieChart.customizeChart(dataPoints: eggNutrients, values: eggNutrientsValues.map( {Double($0)} ))
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightPerTapEnabled = false
        
        pieChart.drawCenterTextEnabled = true
        pieChart.centerText = "Nutrition\nvalues"
        
        
        let l = pieChart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.orientation = .vertical
        l.verticalAlignment = .center
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        pieChart.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        progressPieChart.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(pieChart.snp.bottom)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        chc.snp.makeConstraints{
            $0.top.equalTo(progressPieChart.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
}

