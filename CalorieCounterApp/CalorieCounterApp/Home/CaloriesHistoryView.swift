import UIKit
import SnapKit

class CaloriesHistoryView: UIView{
    
    var mainView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
//        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        
        addSubview(mainView)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
