import UIKit
import SnapKit

class AgeView: UIView{
    private var label: UILabel!
    
    private var numberCollectionView: NumberCollectionView!
            
    private var arrow: UIImageView!
    
    init(){
        super.init(frame: .zero)
                         
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        
        label = UILabel()
        label.text = "Age"
        
        numberCollectionView = NumberCollectionView()
                
        arrow = UIImageView(image: UIImage(systemName: "arrowtriangle.up.fill"))
        arrow.tintColor = .white
        
        addSubview(label)
        addSubview(numberCollectionView)
        addSubview(arrow)
    }
    
    
    func addConstraints(){
        label.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        numberCollectionView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        arrow.snp.makeConstraints{
            $0.top.equalTo(numberCollectionView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func scrollCollectionView(to value: Int){
        numberCollectionView.scrollCollectionView(to: value)
    }
    
    func getValue() -> Int{
        return numberCollectionView.getValue()
    }
}
