import UIKit
import SnapKit

class ConsumedItemView: UIView{
    var dailyNutritionItem: DailyNutritionItemViewModel!
    
    var title: UILabel!
    
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
        title = UILabel()
        title.text = dailyNutritionItem.name
        
        addSubview(title)
    }
    
    func addConstraints(){
        title.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(10)
        }
    }
    
}
