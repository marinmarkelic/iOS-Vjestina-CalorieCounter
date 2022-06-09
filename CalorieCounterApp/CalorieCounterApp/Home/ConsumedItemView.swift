import UIKit
import SnapKit

class ConsumedItemView: UIView{
    var dailyNutritionItem: DailyNutritionItemViewModel!
    var delegate: ConsumedItemViewDelegate!
    
    var title: UILabel!
    var time: UILabel!
    var calories: UILabel!
    
    var closeButton: UIButton!
    
    init(dailyNutritionItem: DailyNutritionItemViewModel, delegate: ConsumedItemViewDelegate) {
        super.init(frame: .zero)
        
        self.dailyNutritionItem = dailyNutritionItem
        self.delegate = delegate
        
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
        title.text = dailyNutritionItem.name.capitalized
        
        time = UILabel()
        time.textColor = elementTitleColor
        time.text = dailyNutritionItem.time
        
        calories = UILabel()
        calories.textColor = .lightGray
        calories.text = "\(dailyNutritionItem.calories) kcal"
        
        closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "minus.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        closeButton.addTarget(self, action: #selector(clickedCloseButton), for: .touchUpInside)
        closeButton.tintColor = .white

        addSubview(title)
        addSubview(time)
        addSubview(calories)
        addSubview(closeButton)
    }
    
    @objc
    func clickedCloseButton(){        
        UIView.animate(withDuration: 0.3, animations: {
            self.isHidden = true
        }, completion: {_ in
            NutritionRepository().deleteItem(self.dailyNutritionItem)
            self.delegate.reloadHomeData()
        })
    }
    
    func addConstraints(){
        title.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        time.snp.makeConstraints{
            $0.top.bottom.equalTo(title)
            $0.leading.equalTo(title.snp.trailing).offset(10)
        }
        
        calories.snp.makeConstraints{
            $0.leading.equalTo(title)
            $0.top.equalTo(title.snp.bottom).offset(20)
        }
        
        closeButton.snp.makeConstraints{
            $0.bottom.trailing.equalToSuperview().offset(-20)
        }
    }
    
}

protocol ConsumedItemViewDelegate{
    func reloadHomeData()
}
