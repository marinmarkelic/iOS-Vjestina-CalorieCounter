import UIKit
import SnapKit

class MealSearchViewController: ViewController{
        
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var searchBar: SearchBarView!
    var mealChart: MealChartView!
    var mealDetails: MealDetailsView!
    var mealAdd: MealAddView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = appBackgroundColor
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        contentView = UIView()
        
        searchBar = SearchBarView()
        searchBar.delegate = self
        
        mealChart = MealChartView()
        
        mealDetails = MealDetailsView()
        
        mealAdd = MealAddView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(mealChart)
        contentView.addSubview(mealDetails)
        contentView.addSubview(mealAdd)
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
        
        searchBar.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
        }
        
        mealChart.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
        }
        
        mealDetails.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mealChart.snp.bottom).offset(10)
        }
        
        mealAdd.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(mealDetails.snp.bottom).offset(15)
        }
    }
}

extension MealSearchViewController: SearchBarDelegate{
    func searchedWithText(text: String) {
        NutritionRepository().loadNutritionData(itemDescription: text, completionHandler: {
            self.mealChart.set($0)
            self.mealDetails.set($0)
            self.mealAdd.set($0)
        })
    }
    
    
}
