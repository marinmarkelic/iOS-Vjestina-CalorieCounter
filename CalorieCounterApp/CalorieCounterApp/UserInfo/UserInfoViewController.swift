import UIKit
import SnapKit

class UserInfoViewController: UIViewController{
    private var gender: Gender?
    private var height: Int?
    private var weight: Int?
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
        
    private var genderSelection: GenderSelection!
    private var heightView: HeightView!
    private var weightView: WeightView!
    
    private var saveButton: UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = appBackgroundColor
        
        loadUserDefaults()
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUserDefaults(){
        let userDefaults = UserDefaults.standard
                
        if userDefaults.string(forKey: "gender") == nil{
            gender = nil
        }
        else{
            gender = Gender(rawValue: Int(userDefaults.string(forKey: "gender")!)!)
        }
        
        if userDefaults.string(forKey: "height") == nil{
            height = nil
        }
        else{
            height = Int(userDefaults.string(forKey: "height")!)
        }
        
        if userDefaults.string(forKey: "weight") == nil{
            weight = nil
        }
        else{
            weight = Int(userDefaults.string(forKey: "weight")!)
        }
    }
    
    func buildViews(){
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        contentView = UIView()
        
        genderSelection = GenderSelection()
        heightView = HeightView()
        weightView = WeightView()
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(genderSelection)
        contentView.addSubview(heightView)
        contentView.addSubview(weightView)
        contentView.addSubview(saveButton)
    }
    
    @objc
    func saveData(){
        
        let userDefaults = UserDefaults.standard
        

        if genderSelection.gender != nil{
            userDefaults.set(String(genderSelection.gender!.rawValue), forKey: "gender")
        }
        
        let h = heightView.getValue() ?? 1
        userDefaults.set(String(h), forKey: "height")
        
        userDefaults.set(String(weightView.getValue()), forKey: "weight")

    }
    
    func reloadData(){
        genderSelection.setButtons(genderValue: gender?.rawValue)
        
        heightView.scrollCollectionView(to: height ?? 170)
        weightView.scrollCollectionView(to: weight ?? 70)
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
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
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
        }
        
        saveButton.snp.makeConstraints{
            $0.top.equalTo(weightView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
        }
    }
}

