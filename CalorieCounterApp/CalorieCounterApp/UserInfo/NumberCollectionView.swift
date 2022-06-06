import UIKit

class NumberCollectionView: UICollectionView{
    
    init(){
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout)
        register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.reuseIdentifier)
        dataSource = self
        delegate = self
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
                         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollCollectionView(to: Int){
        layoutIfNeeded()
        scrollToItem(at: IndexPath(item: to, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func getValue() -> Int{
        let indexArr = indexPathsForVisibleItems.map({$0[1]})
        let sumOfArr = indexArr.reduce(0, +)
        
        return sumOfArr / indexArr.count
    }
}

extension NumberCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 250
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell
        else {
            fatalError()
        }
        
        cell.set(value: indexPath.row)
        
        return cell
    }
}

extension NumberCollectionView: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
//        let itemHeight: CGFloat
//
//        if indexPath.row % 5 == 0{
//            itemHeight = CGFloat(40)
//        }
//        else{
//            itemHeight = CGFloat(20)
//        }
        let itemHeight = CGFloat(20)
        let itemWidth = CGFloat(35)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

//extension NumberCollectionView: UICollectionViewDelegate{
//    override func didAddSubview(_ subview: UIView) {
//        self.scrollCollectionView(to: 170)
//
//    }
//}
