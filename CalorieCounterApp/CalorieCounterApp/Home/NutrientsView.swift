import UIKit
import SnapKit

class NutrientsView: UIView{
    var dailyNutrition: DailyNutritionViewModel!
    
    var collectionView: UICollectionView!
    var collectionViewLayout: UICollectionViewFlowLayout!
    
    init(dailyNutrition: DailyNutritionViewModel) {
        super.init(frame: .zero)
        
        self.dailyNutrition = dailyNutrition
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(dailyNutrition: DailyNutritionViewModel){
        self.dailyNutrition = dailyNutrition
        
        collectionView.reloadData()
    }
    
    func buildViews(){
        backgroundColor = .none
        layer.cornerRadius = 8
        clipsToBounds = true
        
        
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(NutrientsCell.self, forCellWithReuseIdentifier: NutrientsCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(collectionView)
        
    }
    
    func addConstraints(){
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

extension NutrientsView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let _ = meal else{
//            return 0
//        }
        
        return getArrayOfNamesForGrams().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NutrientsCell.reuseIdentifier, for: indexPath) as? NutrientsCell
        else {
            fatalError()
        }
        
        let name = getArrayOfNamesForGrams()[indexPath.row]
        
        cell.set(name: name, value: dailyNutrition.getValue(name: name))
        
        
        return cell
    }
}

extension NutrientsView: UICollectionViewDelegateFlowLayout {

    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 2 * 10) / 3.5
        let itemHeight = CGFloat(frame.height)

        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension NutrientsView: UICollectionViewDelegate{
    
}

