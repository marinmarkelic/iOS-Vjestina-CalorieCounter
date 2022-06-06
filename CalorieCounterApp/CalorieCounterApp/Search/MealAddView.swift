import UIKit
import SnapKit

class MealAddView: UIView{
    var meal: NutritionItemViewModel!
    
    var mainView: UIView!
    
    var label: UILabel!
    var caloriesLabel: UILabel!
    
    var addButton: UIButton!
    
    var amountTextField: UITextField!

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ item: NutritionItemViewModel){
        self.meal = item
                
        buildViews()
        addConstraints()
        
        caloriesLabel.text = String(item.calories) + " kcal"

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
        
        amountTextField.text = "100"
        amountTextField.textColor = .white
        amountTextField.textAlignment = .center
        amountTextField.layer.cornerRadius = 8
        amountTextField.layer.borderColor = UIColor.lightGray.cgColor
        amountTextField.layer.borderWidth = 1
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(refreshCaloriesAmount), for: .editingChanged)

        
        addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addButton.addTarget(self, action: #selector(clickedAddButton), for: .touchUpInside)
        addButton.tintColor = .white

        caloriesLabel = UILabel()
        caloriesLabel.textColor = elementTotalTextColor
        
        addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(amountTextField)
        mainView.addSubview(addButton)
        mainView.addSubview(caloriesLabel)
    }
    
    @objc
    func refreshCaloriesAmount(){
        guard let meal = meal,
              let text = amountTextField.text,
              let value = Float(text) else{
                  caloriesLabel.text = "0.0 kcal"
                  
                  return
              }
                
//        caloriesLabel.text = String((value / meal.serving_size_g) * meal.calories) + " kcal"
        caloriesLabel.text = String(format: "%.1f kcal", (value / meal.serving_size_g) * meal.calories)
    }
    
    @objc
    func clickedAddButton(){
        guard let amount = amountTextField.text,
              amount != "0",
              amount != "" else{
                  DispatchQueue.main.async {
                      let alert = UIAlertController(title: "Invalid amount", message: nil, preferredStyle: UIAlertController.Style.alert)
                      
                      // add an action (button)
                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                      
                      // show the alert
                      self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                  }
                  
                  return
              }
        
        meal.changeServingSize(servingSize: Float(amount) ?? 100)
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
            $0.width.equalTo(45)
        }
        
        addButton.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        caloriesLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(amountTextField.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-20)

        }
    }
}

extension MealAddView: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        refreshCaloriesAmount()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard !string.isEmpty else {
            return true
        }
        
        if Int(string) == nil {
            return false
        }
        
        if textField.text?.count ?? 0 > 3{
            return false
        }

        return true
    }
}
