import UIKit
import SnapKit

class MealSearchViewController: ViewController{
    let loadingSpinner = SpinnerViewController()
        
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var subViewsContainer: UIView!
    
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
        
        subViewsContainer = UIView()
        subViewsContainer.isHidden = true
        
        searchBar = SearchBarView()
        searchBar.delegate = self
        
        mealChart = MealChartView()
        
        mealDetails = MealDetailsView()
        
        mealAdd = MealAddView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(subViewsContainer)
        subViewsContainer.addSubview(mealChart)
        subViewsContainer.addSubview(mealDetails)
        subViewsContainer.addSubview(mealAdd)
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
        
        subViewsContainer.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
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
    
    func showSpinnerView() {
        addChild(loadingSpinner)
        loadingSpinner.view.frame = view.frame
        view.addSubview(loadingSpinner.view)
        loadingSpinner.didMove(toParent: self)
    }
    
    func hideSpinnerView(){
        loadingSpinner.willMove(toParent: nil)
        loadingSpinner.view.removeFromSuperview()
        loadingSpinner.removeFromParent()
    }
}

extension MealSearchViewController: SearchBarDelegate{
    func searchedWithText(text: String) {
        showSpinnerView()
        
        NutritionRepository().loadNutritionData(itemDescription: text, completionHandler: {
            self.hideSpinnerView()
            
            guard let item = $0 else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Couldn't find item", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                return
            }
            
            self.mealChart.set(item)
            self.mealDetails.set(item)
            self.mealAdd.set(item)
            
            if self.subViewsContainer.isHidden == true{
                self.subViewsContainer.isHidden = false
            }
        })
    }
    
    
}
