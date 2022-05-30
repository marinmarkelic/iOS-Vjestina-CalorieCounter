import UIKit
import SnapKit

class HomeViewController: ViewController{
    
    var mainView: UIView!
    
    var label: UILabel!
    var caloriesView: CaloriesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        view.backgroundColor = appBackgroundColor
        
        mainView = UIView()
        
        label = UILabel()
        label.text = "Calories"
        label.textColor = .lightGray
        
        caloriesView = CaloriesView()
        
        view.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(caloriesView)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        label.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        caloriesView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}
