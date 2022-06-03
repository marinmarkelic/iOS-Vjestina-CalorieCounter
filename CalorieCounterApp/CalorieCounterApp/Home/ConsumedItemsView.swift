import UIKit
import SnapKit

class ConsumedItemsView: UIView{
    var dailyNutrition: DailyNutritionViewModel!
    var ConsumedItemViewDelegate: ConsumedItemViewDelegate!
    
    var stackViewContainer: UIView!
        
    var label: UILabel!
    var stackView: UIStackView!
    
        
    init(dailyNutrition: DailyNutritionViewModel, ConsumedItemViewDelegate: ConsumedItemViewDelegate) {
        super.init(frame: .zero)
        
        self.dailyNutrition = dailyNutrition
        self.ConsumedItemViewDelegate = ConsumedItemViewDelegate
        
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
            let view = ConsumedItemView(dailyNutritionItem: i, delegate: ConsumedItemViewDelegate)
            
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
