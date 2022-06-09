import UIKit
import SnapKit

class MealAddView: UIView{
    private var meal: NutritionItemViewModel!
    
    private var mainView: UIView!
    
    private var label: UILabel!
    private var caloriesLabel: UILabel!
    
    private var addButton: UIButton!
    
    private var amountTextField: UITextField!
    private var gramsLabel: UILabel!

    init() {
        super.init(frame: .zero)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ item: NutritionItemViewModel){
        self.meal = item
                
        caloriesLabel.text = String(item.calories) + " kcal"
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        mainView.clipsToBounds = true
        
        label = UILabel()
        label.text = "Add item"
        label.textColor = elementTitleColor
        
        amountTextField = UITextField()
        amountTextField.text = "100"
        amountTextField.textColor = .white
        amountTextField.textAlignment = .center
        amountTextField.layer.cornerRadius = 6
//        amountTextField.layer.borderColor = UIColor.lightGray.cgColor
        amountTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        amountTextField.layer.borderWidth = 1
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(refreshCaloriesAmount), for: .editingChanged)
        
        gramsLabel = UILabel()
        gramsLabel.textColor = .lightGray
        gramsLabel.text = "g"

        addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        addButton.addTarget(self, action: #selector(clickedAddButton), for: .touchUpInside)
        addButton.tintColor = .white

        caloriesLabel = UILabel()
        caloriesLabel.textColor = elementTotalTextColor
        
        addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(amountTextField)
        mainView.addSubview(gramsLabel)
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
                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
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
        }
        
        gramsLabel.snp.makeConstraints{
            $0.top.equalTo(amountTextField)
            $0.leading.equalTo(amountTextField.snp.trailing).offset(5)
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
