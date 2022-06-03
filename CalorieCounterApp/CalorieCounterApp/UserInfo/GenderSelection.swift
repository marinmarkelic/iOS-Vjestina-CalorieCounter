import UIKit
import SnapKit

class GenderSelection: UIView{
    var mainView: UIView!
    
    var label: UILabel!
    
    var maleRadioButton: RadioButton!
    var femaleRadioButton: RadioButton!

    
    init(){
        super.init(frame: .zero)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
//        mainView.backgroundColor = elementBackgroundColor
//        mainView.layer.cornerRadius = 8
//        mainView.clipsToBounds = false
        
        label = UILabel()
        label.text = "Gender"
        
        maleRadioButton = RadioButton(name: "Male")
        femaleRadioButton = RadioButton(name: "Female")
        
        maleRadioButton?.alternateButton = [femaleRadioButton!]
        femaleRadioButton?.alternateButton = [maleRadioButton!]
        
        maleRadioButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        maleRadioButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        
        addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(maleRadioButton)
        mainView.addSubview(femaleRadioButton)
    }
    
    @objc
    func toggleButton() {
        print("click")
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        label.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        
        maleRadioButton.snp.makeConstraints{
            $0.leading.equalTo(label)
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2)
        }
        
        femaleRadioButton.snp.makeConstraints{
            $0.leading.equalTo(maleRadioButton.snp.trailing)
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2)
        }
    }
}
