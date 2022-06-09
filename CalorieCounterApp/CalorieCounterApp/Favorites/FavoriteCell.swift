import UIKit
import SnapKit

class FavoriteCell: UIView{
    private var item: NutritionItemViewModel!
    private var delegate: FavoriteCellDelegate!
    
    private var name: UILabel!
    private var calories: UILabel!
    
    private var favoriteButton: UIButton!
    private var addButton: UIButton!
    
    private var amountTextField: UITextField!
    private var gramsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ item: DailyNutritionItemViewModel, delegate: FavoriteCellDelegate){
        self.item = NutritionItemViewModel(item)
        self.delegate = delegate
        
        name.text = item.name.capitalized
        calories.text = String(format: "%.1f kcal", item.calories)
        
        if NutritionRepository().isItemFavorite(name: item.name){
            favoriteButton.isSelected = true
        }
    }
    
    func buildViews(){
        backgroundColor = elementBackgroundColor
        layer.cornerRadius = 8
        
        name = UILabel()
        name.textColor = elementEnteredTextColor
        
        calories = UILabel()
        calories.textColor = elementTitleColor
        
        favoriteButton = UIButton()
        favoriteButton.tintColor = .white
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favoriteButton.addTarget(self, action: #selector(clickedFavoriteButton), for: .touchUpInside)
        
        addButton = UIButton()
        addButton.tintColor = .white
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        addButton.addTarget(self, action: #selector(clickedAddButton), for: .touchUpInside)
        
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
                
        addSubview(name)
        addSubview(calories)
        addSubview(favoriteButton)
        addSubview(addButton)
        addSubview(amountTextField)
        addSubview(gramsLabel)
    }
    
    @objc
    func refreshCaloriesAmount(){
        guard let item = item,
              let text = amountTextField.text,
              let value = Float(text) else{
                  calories.text = "0.0 kcal"
                  
                  return
              }
                
        calories.text = String(format: "%.1f kcal", (value / item.serving_size_g) * item.calories)
    }
    
    @objc
    func clickedFavoriteButton(){
        UIView.animate(withDuration: 0.3, animations: {
            self.isHidden = true
        }, completion: {_ in
            NutritionRepository().removeItemFromFavorites(self.item!)
            self.delegate.unfavoritedItem(self.item.name)
        })
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
        
        item.changeServingSize(servingSize: Float(amount) ?? 100)
        NutritionRepository().addItem(item){
            var message = ""
            switch $0{
            case true:
                message = "Added item"
            case false:
                message = "Failed to add item"
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func addConstraints(){
        
        name.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        amountTextField.snp.makeConstraints{
            $0.leading.equalTo(name)
            $0.top.equalTo(name.snp.bottom).offset(25)
        }
        
        gramsLabel.snp.makeConstraints{
            $0.top.equalTo(amountTextField)
            $0.leading.equalTo(amountTextField.snp.trailing).offset(5)
        }
        
        calories.snp.makeConstraints{
            $0.leading.equalTo(name.snp.trailing).offset(10)
            $0.top.equalTo(name)
        }
        
        favoriteButton.snp.makeConstraints{
            $0.top.equalTo(name)
            $0.centerX.equalTo(addButton)
        }
        
        addButton.snp.makeConstraints{
            $0.top.equalTo(amountTextField)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}

protocol FavoriteCellDelegate{
    func unfavoritedItem(_ name: String)
}

extension FavoriteCell: UITextFieldDelegate{
    
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
