import UIKit
import SnapKit

class MealChartView: UIView{
    var mainView: UIView!
    
    var items: NutritionItemViewModel!
    
    var titleLabel: UILabel!
    var itemNameLabel: UILabel!
    
    var favoriteButton: UIButton!
    
    var pieChart: CustomPieChartView!
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
        addConstraints()
    }
    
    func set(_ items: NutritionItemViewModel){
        self.items = items
                
        itemNameLabel.text = items.name.capitalized
        pieChart.customizeChart(dataPoints: items.getArrayOfNamesForGrams(), values: items.getArrayOfValuesForGrams().map({Double($0)}))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        
        titleLabel = UILabel()
        titleLabel.text = "Nutritional information"
        titleLabel.textColor = elementTitleColor
        
        itemNameLabel = UILabel()
        itemNameLabel.textColor = elementEnteredTextColor
        
        favoriteButton = UIButton()
        
        pieChart = CustomPieChartView()
        configurePieChart()

        
        addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(itemNameLabel)
        mainView.addSubview(favoriteButton)
        mainView.addSubview(pieChart)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        itemNameLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
        }
        
        favoriteButton.snp.makeConstraints{
            $0.top.equalTo(itemNameLabel)
            $0.trailing.equalToSuperview()
        }
        
        pieChart.snp.makeConstraints{
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configurePieChart(){
//        pieChart.customizeChart(dataPoints: eggNutrients, values: eggNutrientsValues.map( {Double($0)} ))
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightPerTapEnabled = false
        
        pieChart.drawCenterTextEnabled = true
//        pieChart.centerText = "Nutrition\nvalues"
        pieChart.holeColor = elementBackgroundColor
        
        
        let l = pieChart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.orientation = .vertical
        l.verticalAlignment = .center
        l.textColor = .white
    }
}
