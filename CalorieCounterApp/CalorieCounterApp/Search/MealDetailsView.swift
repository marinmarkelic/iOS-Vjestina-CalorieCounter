import UIKit
import SnapKit

class MealDetailsView: UIView{
    
    var meal: NutritionItemViewModel!
    
    var mainView = UIView()
    
    var collectionViewContainer: UIView!
    var collectionView: UICollectionView!
    
    var portionSizeLabel: UILabel!

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ items: NutritionItemViewModel){
        self.meal = items
        
       
                
        buildViews()
        addConstraints()
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = .none
        mainView.layer.cornerRadius = 8
        mainView.clipsToBounds = true
        
        collectionViewContainer = UIView()
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(MealDetailsCell.self, forCellWithReuseIdentifier: MealDetailsCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        
        portionSizeLabel = UILabel()
        portionSizeLabel.textColor = elementTitleColor
        if meal == nil{
            portionSizeLabel.text = "Portion size: " + String(0) + " g"

        }
        else{
            portionSizeLabel.text = "Portion size: " + String(meal.serving_size_g) + " g"

        }
        
        addSubview(mainView)
        mainView.addSubview(collectionView)
        mainView.addSubview(portionSizeLabel)
//        collectionViewContainer.addSubview(collectionView)
        
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
//        collectionViewContainer.snp.makeConstraints{
//            $0.leading.trailing.top.equalToSuperview()
//            $0.bottom.equalTo(portionSizeLabel.snp.top)
//            $0.height.equalTo(100)
//        }

        collectionView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            
            $0.height.equalTo(100)
        }
        
        portionSizeLabel.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MealDetailsView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("reload")
//        guard let _ = meal else{
//            return 0
//        }
        
        return getArrayOfNamesForGrams().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealDetailsCell.reuseIdentifier, for: indexPath) as? MealDetailsCell
        else {
            fatalError()
        }
        
        guard let meal = meal else{
            return cell
        }
        
        let name = getArrayOfNamesForGrams()[indexPath.row]
        
        cell.set(name: name, value: meal.valueForName(name: name))
        
        
        return cell
    }
}

extension MealDetailsView: UICollectionViewDelegateFlowLayout {

    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 2 * 10) / 4
        let itemHeight = CGFloat(collectionViewContainer.frame.height / 1.4)

        return CGSize(width: itemWidth, height: CGFloat(100))
    }
}

extension MealDetailsView: UICollectionViewDelegate{
    
}
