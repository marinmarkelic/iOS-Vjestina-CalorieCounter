import UIKit
import SnapKit

class FavoritesViewController: UIViewController{
    var mainView: UIView!
    
    var label: UILabel!
    
    var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = appBackgroundColor
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
    
    func buildViews(){
        mainView = UIView()
        
        label = UILabel()
        label.text = "Favorites"
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(collectionView)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        label.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(NutritionRepository().getAllFavorites().count)
        return NutritionRepository().getAllFavorites().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as? FavoriteCell
        else {
            fatalError()
        }
         
        cell.set(NutritionRepository().getAllFavorites()[indexPath.row], delegate: self)
        
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {

    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        
        let itemWidth = collectionView.frame.width
        let itemHeight = 100

        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
        
    }
}

extension FavoritesViewController: UICollectionViewDelegate{
    
}

extension FavoritesViewController: FavoriteCellDelegate{
    func unfavoritedItem(_ name: String){
        print("reloading")
        DispatchQueue.main.async {

            self.collectionView.deleteItems(at: [IndexPath(row: 0, section: NutritionRepository().getAllFavorites().firstIndex(where: {
                $0.name == name
            }) ?? 0)])
//            self.collectionView.layoutIfNeeded()

//            self.collectionView.reloadData()
        }
    }
}
