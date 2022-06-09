import UIKit
import SnapKit

class SearchBarView: UIView{
    
    var delegate: SearchBarDelegate!
        
    var mainView: UIStackView!
    var grayView: UIView!
    
    var textField: UITextField!
    var deleteButton: UIButton!
    var searchButton: UIButton!
    
    
    init(){
        super.init(frame: .zero)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIStackView()
        mainView.spacing = 10
        
        grayView = UIView()
        grayView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.8)
        grayView.layer.cornerRadius = 10
                
        textField = UITextField()
        textField.placeholder = "Search"
        textField.delegate = self
        
        deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "multiply", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(clickedDeleteButton), for: .touchUpInside)
        deleteButton.tintColor = .black
        
        searchButton = UIButton()
//        searchButton.setTitle("Search", for: .normal)
//        searchButton.setTitleColor(.white, for: .normal)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        searchButton.tintColor = .white
        
        


        searchButton.isHidden = true
        searchButton.addTarget(self, action: #selector(clickedSearchButton), for: .touchUpInside)
        
        addSubview(mainView)
        mainView.addArrangedSubview(grayView)
        grayView.addSubview(textField)
        grayView.addSubview(deleteButton)
        mainView.addArrangedSubview(searchButton)
    }
    
    @objc
    func clickedSearchButton(){
        guard let text = textField.text else{
            searchButton.isHidden = true
            deleteButton.isHidden = true
            textField.text = ""
            textField.endEditing(true)
            return
        }
        
        delegate.searchedWithText(text: text)
        
        searchButton.isHidden = true
        deleteButton.isHidden = true
        textField.text = ""
        textField.endEditing(true)
        
    }
    
    @objc
    func clickedDeleteButton(){
        deleteButton.isHidden = true
        textField.text = ""
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        grayView.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(50)
        }

        
        textField.snp.makeConstraints{
            $0.leading.equalTo(grayView).offset(10)
            $0.trailing.equalTo(deleteButton)
            $0.top.equalToSuperview().offset(15)
        }
        
        deleteButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(17)
            $0.width.height.equalTo(15)
        }
        
        searchButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.width.equalTo(30)
        }
        
    }
}


extension SearchBarView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Begin typing")
        
        searchButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Stopped typing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        deleteButton.isHidden = false
        //  Hides the X button if we deleted all characteres
        if(range.lowerBound == 0 && range.upperBound > 0){
            deleteButton.isHidden = true
        }
        
        return true
    }
    
    
}

protocol SearchBarDelegate{
    func searchedWithText(text: String)
}


