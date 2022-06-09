import UIKit
import SnapKit

class UserInfoViewController: UIViewController{
    private var gender: Gender!
    private var height: Int!
    private var weight: Int!
    private var age: Int!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
        
    private var genderSelection: GenderSelection!
    private var heightView: HeightView!
    private var weightView: WeightView!
    private var ageView: AgeView!
    
    private var saveButton: UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = appBackgroundColor
        
        buildViews()
        addConstraints()
        reloadData()
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
        ageView = AgeView()
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .lightGray.withAlphaComponent(0.6)

        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(genderSelection)
        contentView.addSubview(heightView)
        contentView.addSubview(weightView)
        contentView.addSubview(ageView)
        contentView.addSubview(saveButton)
    }
    
    @objc
    func saveData(){
        let userDefaults = UserDefaults.standard
        

        if genderSelection.gender != nil{
            userDefaults.set(genderSelection.gender!.rawValue, forKey: "gender")
        }
        
        let h = heightView.getValue() ?? 1
        userDefaults.set(h, forKey: "height")
        
        userDefaults.set(weightView.getValue(), forKey: "weight")
        userDefaults.set(ageView.getValue(), forKey: "age")
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Saved user info", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }


        reloadData()
    }
    
    func loadUserDefaults(){
        let userDefaults = UserDefaults.standard
        
        self.gender = Gender(rawValue: userDefaults.integer(forKey: "gender"))
        self.height = userDefaults.integer(forKey: "height")
        self.weight = userDefaults.integer(forKey: "weight")
        self.age = userDefaults.integer(forKey: "age")
    }
    
    func reloadData(){
        loadUserDefaults()
        
        genderSelection.setButtons(genderValue: gender?.rawValue)
        
        if height == 0 && weight == 0 && age == 0{
            height = 170
            weight = 70
            age = 18
        }
                
        heightView.scrollCollectionView(to: height ?? 170)
        weightView.scrollCollectionView(to: weight ?? 70)
        ageView.scrollCollectionView(to: age ?? 18)
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
            $0.top.equalTo(genderSelection.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(80)
        }
        
        weightView.snp.makeConstraints{
            $0.top.equalTo(heightView.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview()
        }
        
        ageView.snp.makeConstraints{
            $0.top.equalTo(weightView.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints{
            $0.top.equalTo(ageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(60)
            $0.bottom.equalToSuperview()
        }
    }
}

