import UIKit
import SnapKit

class HeightView: UIView{
    private var label: UILabel!
    
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
        
    private var value: UILabel!
    
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
        label.text = "Height"
        label.textColor = .white.withAlphaComponent(0.8)

        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(HeightViewCell.self, forCellWithReuseIdentifier: HeightViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
                
        value = UILabel()
        value.textColor = .white
        value.text = " "
        
        addSubview(label)
        addSubview(collectionView)
        addSubview(value)
    }
    
    func addConstraints(){
        label.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        value.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func scrollCollectionView(to: Int){
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: to, section: 0), at: .centeredHorizontally, animated: true)

        myGroup.leave()
        myGroup.notify(queue: DispatchQueue.main) {
            self.value.text = String(to)
        }
    }

    
    func getValue() -> Int?{
        return try? Int(value.text ?? "1", format: .number)
    }
}

extension HeightView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        250
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

extension HeightView: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let itemHeight: CGFloat
        
        if indexPath.row % 5 == 0{
            itemHeight = CGFloat(40)
        }
        else{
            itemHeight = CGFloat(20)
        }
        let itemWidth = CGFloat(2)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension HeightView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let indexArr = collectionView.indexPathsForVisibleItems.map({$0[1]})
        let sumOfArr = indexArr.reduce(0, +)
                
        if indexArr.count == 0{
            return
        }
        
        value.text = String(sumOfArr / indexArr.count)
    }
}
