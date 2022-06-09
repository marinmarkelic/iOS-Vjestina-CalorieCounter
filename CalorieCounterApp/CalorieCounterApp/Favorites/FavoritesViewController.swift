import UIKit
import SnapKit

class FavoritesViewController: UIViewController{
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var label: UILabel!
        
    var stackViewContainer: UIView!
    var stackView: UIStackView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = appBackgroundColor
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        for view in stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        addStackViewElements()
    }
    
    func buildViews(){
        scrollView = UIScrollView()
        contentView = UIView()
        
        label = UILabel()
        label.text = "Favorites"
        label.textColor = .lightGray
                
        stackViewContainer = UIView()
        stackViewContainer.clipsToBounds = true
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading // 2.
        stackView.distribution = .equalSpacing // 3.
        stackView.spacing = 10
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(stackViewContainer)
        stackViewContainer.addSubview(stackView)
    }
    
    func addStackViewElements(){
        
        for i in NutritionRepository().getAllFavorites(){
            let view = FavoriteCell()
            view.set(i, delegate: self)
            stackView.addArrangedSubview(view)
                                    
            view.snp.makeConstraints{
//                $0.height.equalTo(100)
                $0.leading.trailing.equalToSuperview()
            }
        }
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
        
        label.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        stackViewContainer.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
extension FavoritesViewController: FavoriteCellDelegate{
    func unfavoritedItem(_ name: String){
        print("reloading")
        
    }
}
