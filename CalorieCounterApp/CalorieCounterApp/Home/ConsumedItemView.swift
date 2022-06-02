import UIKit
import SnapKit

class ConsumedItemView: UIView{
    var dailyNutritionItem: DailyNutritionItemViewModel!
    
    var title: UILabel!
    var time: UILabel!
    var calories: UILabel!
    
    init(dailyNutritionItem: DailyNutritionItemViewModel) {
        super.init(frame: .zero)
        
        self.dailyNutritionItem = dailyNutritionItem
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        backgroundColor = elementBackgroundColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        title = UILabel()
        title.textColor = elementEnteredTextColor
        title.text = dailyNutritionItem.name
        
        time = UILabel()
        time.textColor = elementTitleColor
        time.text = dailyNutritionItem.time
        
        calories = UILabel()
        calories.textColor = .lightGray
        calories.text = "\(dailyNutritionItem.calories) kcal"
        
        addSubview(title)
        addSubview(time)
        addSubview(calories)
    }
    
    func addConstraints(){
        title.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(10)
        }
        
        time.snp.makeConstraints{
            $0.top.equalTo(title)
            $0.leading.equalTo(title.snp.trailing).offset(10)
        }
        
        calories.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(title.snp.bottom).offset(20)
        }
    }
    
}