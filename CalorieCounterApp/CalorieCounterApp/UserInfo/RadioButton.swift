import UIKit

class RadioButton: UIButton {
    var alternateButton: Array<RadioButton>?
    
    required init(name: String) {
        super.init(frame: .zero)
        
        setTitle(name, for: .normal)
        titleLabel?.isUserInteractionEnabled = false
        isUserInteractionEnabled = true
//        addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    @objc
    func toggleButton() {
        print("click")
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.magenta.cgColor
            } else {
                self.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
}
