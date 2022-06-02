import UIKit
import SnapKit

class HomeViewController: ViewController{
    
    var dailyNutrition: DailyNutritionViewModel!
    
    var mainView: UIView!
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var label: UILabel!
    var historyView: CaloriesHistoryView!
    var caloriesView: CaloriesView!
    var nutrientsView: NutrientsView!
    var consumedItemsView: ConsumedItemsView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        dailyNutrition = NutritionRepository().fetchDailyNutrition()
        if dailyNutrition == nil{
            print("HWC daily nutrition nil")
        }
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        dailyNutrition = NutritionRepository().fetchDailyNutrition()
        
        caloriesView.reloadData(consumedCalories: dailyNutrition.calories)
        nutrientsView.reloadData(dailyNutrition: dailyNutrition)
        consumedItemsView.reloadData(dailyNutrition: dailyNutrition)
        
        let data = NutritionRepository().fetchAllDailyNutrition()
        if data != nil{
            historyView.reloadData(dataPoints: data!.map({$0.date}), values: data!.map({$0.calories}))
        }
    }
    
    func buildViews(){
        view.backgroundColor = appBackgroundColor
        
        mainView = UIView()
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        contentView = UIView()
        
        historyView = CaloriesHistoryView()
        let data = NutritionRepository().fetchAllDailyNutrition()
        if data != nil{
            historyView.reloadData(dataPoints: data!.map({$0.date}), values: data!.map({$0.calories}))
//            historyView.historyChart.customizeChart(dataPoints: data!.map({$0.date}), values: data!.map({$0.calories}))
        }
        
        label = UILabel()
        label.text = "Today"
        label.textColor = .lightGray
        
        caloriesView = CaloriesView(consumedCalories: dailyNutrition.calories)
        
        nutrientsView = NutrientsView(dailyNutrition: dailyNutrition)
        
        consumedItemsView = ConsumedItemsView(dailyNutrition: dailyNutrition)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(historyView)
        contentView.addSubview(label)
        contentView.addSubview(caloriesView)
        contentView.addSubview(nutrientsView)
        contentView.addSubview(consumedItemsView)
    }
    
    func addConstraints(){
        scrollView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        historyView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        label.snp.makeConstraints{
            $0.top.equalTo(historyView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        caloriesView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        nutrientsView.snp.makeConstraints{
            $0.top.equalTo(caloriesView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        consumedItemsView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
            $0.top.equalTo(nutrientsView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()

        }
    }
}

// Put on the last element
//  $0.bottom.equalTo(contentView)

