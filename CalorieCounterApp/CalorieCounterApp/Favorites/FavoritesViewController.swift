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
        collectionView.reloadData()
    }
    
    func buildViews(){
        mainView = UIView()
        
        label = UILabel()
        label.text = "Favorites"
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(HeightViewCell.self, forCellWithReuseIdentifier: HeightViewCell.reuseIdentifier)
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
        NutritionRepository().getAllFavorites().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeightViewCell.reuseIdentifier, for: indexPath) as? HeightViewCell
        else {
            fatalError()
        }
         
        
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

        let itemWidth = 10
        let itemHeight = 10

        return CGSize(width: itemWidth, height: itemHeight)    }
}

extension FavoritesViewController: UICollectionViewDelegate{
    
}

