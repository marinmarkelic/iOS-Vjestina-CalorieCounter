import UIKit


class HeightViewCell: UICollectionViewCell{
    static let reuseIdentifier = String(describing: HeightView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .lightGray.withAlphaComponent(0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
