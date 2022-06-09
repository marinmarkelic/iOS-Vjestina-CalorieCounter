import UIKit
import SnapKit

class GenderSelection: UIView{
    var gender: Gender?
    
    private var mainView: UIView!
    
    private var label: UILabel!
    
    private var maleButton: UIButton!
    private var femaleButton: UIButton!
    
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
        label.textColor = .white.withAlphaComponent(0.8)

        maleButton = UIButton()
        maleButton.setTitle("Male", for: .normal)
        maleButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        maleButton.layer.cornerRadius = 8
        maleButton.tag = 0
        
        femaleButton = UIButton()
        femaleButton.setTitle("Female", for: .normal)
        femaleButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        femaleButton.layer.cornerRadius = 8
        femaleButton.tag = 1
        
        addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(maleButton)
        mainView.addSubview(femaleButton)
        
    }
    
    @objc
    func toggleButton(sender: UIButton) {
        setButtons(genderValue: sender.tag)
    }
    
    func setButtons(genderValue: Int?){
        guard let genderValue = genderValue else {
            return
        }
        
        switch genderValue{
        case 0:
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
                self.maleButton.backgroundColor = .lightGray.withAlphaComponent(0.6)
                self.femaleButton.backgroundColor = .clear
            }, completion: {_ in
                self.gender = .male
            })
            
        case 1:
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
                self.maleButton.backgroundColor = .clear
                self.femaleButton.backgroundColor = .lightGray.withAlphaComponent(0.6)
            }, completion: {_ in
                self.gender = .female
            })
        default:
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
                self.maleButton.backgroundColor = .clear
                self.femaleButton.backgroundColor = .clear
            }, completion: {_ in
                self.gender = nil
            })
        }
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
        
        maleButton.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2.1)
        }
        
        femaleButton.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2.1)
        }
    }
}
