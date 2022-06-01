import UIKit
import SnapKit

class HomeViewController: ViewController{
    
    var dailyNutrition: DailyNutritionViewModel!
    
    var mainView: UIView!
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var label: UILabel!
    var caloriesView: CaloriesView!
    var nutrientsView: NutrientsView!
    
    
    
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
    
    func buildViews(){
        view.backgroundColor = appBackgroundColor
        
        mainView = UIView()
        
        scrollView = UIScrollView()
        contentView = UIView()
        
        label = UILabel()
        label.text = "Today"
        label.textColor = .lightGray
        
        caloriesView = CaloriesView(consumedCalories: dailyNutrition.calories)
        
        nutrientsView = NutrientsView(dailyNutrition: dailyNutrition)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(caloriesView)
        contentView.addSubview(nutrientsView)
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
        
        label.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
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
            $0.bottom.equalTo(contentView)
        }
    }
}

// Put on the last element
//  $0.bottom.equalTo(contentView)

