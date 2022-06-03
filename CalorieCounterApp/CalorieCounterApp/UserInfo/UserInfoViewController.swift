import UIKit
import SnapKit

class UserInfoViewController: UIViewController{
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var genderSelection: GenderSelection!
    var heightView: HeightView!
    var weightView: WeightView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = appBackgroundColor
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        contentView = UIView()
        
        genderSelection = GenderSelection()
        heightView = HeightView()
        weightView = WeightView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(genderSelection)
        contentView.addSubview(heightView)
        contentView.addSubview(weightView)
    }
    
    func addConstraints(){
        scrollView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        genderSelection.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        heightView.snp.makeConstraints{
            $0.top.equalTo(genderSelection.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(80)
        }
        
        weightView.snp.makeConstraints{
            $0.top.equalTo(heightView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
