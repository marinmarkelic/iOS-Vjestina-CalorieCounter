import UIKit
import SnapKit

class WeightViewCell: UICollectionViewCell{
    static let reuseIdentifier = String(describing: WeightView.self)
    
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                        
        label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        
        addSubview(label)
        
        label.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(value: Int){
        label.text = String(value)
    }
    
    func enableHighlight(){
        label.textColor = .red
    }
}
