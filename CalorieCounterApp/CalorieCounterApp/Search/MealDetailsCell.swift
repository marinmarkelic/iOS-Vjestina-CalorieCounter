import UIKit
import SnapKit

class MealDetailsCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: MealDetailsView.self)
    
    var name: UILabel!
    var value: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, value: Float){
        self.name.text = name
        self.value.text = String(value) + " g"
    }
    
    func buildViews(){
        backgroundColor = elementBackgroundColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        name = UILabel()
        name.textAlignment = .center
        name.textColor = elementEnteredTextColor
        
        value = UILabel()
        value.textAlignment = .center
        value.textColor = elementTitleColor
        
        addSubview(name)
        addSubview(value)
    }
    
    func addConstraints(){
        name.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        value.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(name.snp.bottom)
        }
    }

}
