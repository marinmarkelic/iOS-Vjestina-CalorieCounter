import UIKit
import SnapKit

class ConsumedItemsView: UIView{
    var dailyNutrition: DailyNutritionViewModel!
    
    var stackViewContainer: UIView!
        
    var label: UILabel!
    var stackView: UIStackView!
    
    
    var isus: TempCell!
    
    init(dailyNutrition: DailyNutritionViewModel) {
        super.init(frame: .zero)
        
        self.dailyNutrition = dailyNutrition
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(dailyNutrition: DailyNutritionViewModel){
        self.dailyNutrition = dailyNutrition
        
        for view in stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        addStackViewElements()
    }
    
    func buildViews(){
        stackViewContainer = UIView()
        stackViewContainer.backgroundColor = .none
        stackViewContainer.layer.cornerRadius = 8
        stackViewContainer.clipsToBounds = true
        
        label = UILabel()
        label.text = "Consumed items"
        label.textColor = .lightGray
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading // 2.
        stackView.distribution = .equalSpacing // 3.
        stackView.spacing = 10
        
        addStackViewElements()
        
        addSubview(label)
        addSubview(stackViewContainer)
        stackViewContainer.addSubview(stackView)
    }
    
    func addStackViewElements(){
        for i in dailyNutrition.items.sorted(by: {$0.time > $1.time}){
            let view = ConsumedItemView(dailyNutritionItem: i)
            
            stackView.addArrangedSubview(view)
                                    
            view.snp.makeConstraints{
                $0.height.equalTo(100)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
    
    func addConstraints(){
        label.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
        }
        
        stackViewContainer.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

class TempCell: UIView{
    var view: UIView!
    var label: UILabel!

    
    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        
        translatesAutoresizingMaskIntoConstraints = false
        
        view = UIView()
        
        label = UILabel()
        label.text = "oof"
        
                
        addSubview(view)
        view.addSubview(label)
        
        
        label.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
