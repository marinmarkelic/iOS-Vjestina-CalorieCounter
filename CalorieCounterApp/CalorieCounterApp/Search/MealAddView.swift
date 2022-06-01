import UIKit
import SnapKit

class MealAddView: UIView{
    var meal: NutritionItemViewModel!
    
    var mainView: UIView!
    
    var label: UILabel!
    
    var addButton: UIButton!
    
    var amountTextField: UITextField!

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ items: NutritionItemViewModel){
        self.meal = items
                
        buildViews()
        addConstraints()
    }
    
    func buildViews(){
        if mainView == nil{
            mainView = UIView()
            amountTextField = UITextField()
            label = UILabel()
            addButton = UIButton()

        }
        
        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        mainView.clipsToBounds = true
        
        label.text = "Add item"
        label.textColor = elementTitleColor
        
        amountTextField.text = "100.0"
        amountTextField.backgroundColor = .black
        amountTextField.textColor = .white
        
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(clickedAddButton), for: .touchUpInside)

        
        addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(amountTextField)
        addSubview(addButton)
    }
    
    @objc
    func clickedAddButton(){
        NutritionRepository().addItem(meal){
            var message = ""
            switch $0{
            case true:
                message = "Added item"
            case false:
                message = "Failed to add item"
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        amountTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        addButton.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalTo(amountTextField.snp.trailing).offset(20)
        }
    }
}
