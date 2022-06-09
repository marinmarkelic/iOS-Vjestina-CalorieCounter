import UIKit
import SnapKit

class FavoriteCell: UICollectionViewCell{
    static let reuseIdentifier = String(describing: FavoritesViewController.self)
    
    private var item: NutritionItemViewModel!
    private var delegate: FavoriteCellDelegate!
    
    private var name: UILabel!
    private var calories: UILabel!
    
    private var         favoriteButton: UIButton!
    private var addButton: UIButton!
    private var expandButton: UIButton!
    
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
        
        name.text = item.name
        calories.text = String(format: "%.1f kcal", item.calories)
        
        if NutritionRepository().isItemFavorite(name: item.name){
            favoriteButton.isSelected = true
        }
        else{
            self.isHidden = true
        }
    }
    
    func buildViews(){
        backgroundColor = elementBackgroundColor
        layer.cornerRadius = 8
        
        name = UILabel()
        
        calories = UILabel()
        
        favoriteButton = UIButton()
        favoriteButton.tintColor = .white
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favoriteButton.addTarget(self, action: #selector(clickedFavoriteButton), for: .touchUpInside)
        
        
        //        expandButton = UIButton()
        //        expandButton.setImage(UIImage(named: "star"), for: .normal)
        //        expandButton.addTarget(self, action: #selector(expandButtonClicked), for: .touchUpInside)
        
        addSubview(name)
        addSubview(calories)
        addSubview(favoriteButton)
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
    
    func addConstraints(){
        name.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        calories.snp.makeConstraints{
            $0.leading.equalTo(name)
            $0.top.equalTo(name.snp.bottom).offset(10)
        }
        
        favoriteButton.snp.makeConstraints{
            $0.top.equalTo(calories)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

protocol FavoriteCellDelegate{
    func unfavoritedItem(_ name: String)
}
