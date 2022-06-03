import UIKit
import SnapKit

class WeightView: UIView{
    private var label: UILabel!
    
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    
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
        label.text = "Weight"
        
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(WeightViewCell.self, forCellWithReuseIdentifier: WeightViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        
        arrow = UIImageView(image: UIImage(systemName: "arrowtriangle.up.fill"))
        
        addSubview(label)
        addSubview(collectionView)
        addSubview(arrow)
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
        
        arrow.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}

final class SnapCenterLayout: UICollectionViewFlowLayout {
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
    let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)

    let itemSpace = itemSize.width + minimumInteritemSpacing
    var currentItemIdx = round(collectionView.contentOffset.x / itemSpace)

    // Skip to the next cell, if there is residual scrolling velocity left.
    // This helps to prevent glitches
    let vX = velocity.x
    if vX > 0 {
      currentItemIdx += 1
    } else if vX < 0 {
      currentItemIdx -= 1
    }

    let nearestPageOffset = currentItemIdx * itemSpace
    return CGPoint(x: nearestPageOffset,
                   y: parent.y)
  }
}

extension WeightView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 250
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeightViewCell.reuseIdentifier, for: indexPath) as? WeightViewCell
        else {
            fatalError()
        }
        
        cell.set(value: indexPath.row)
        
        return cell
    }
}

extension WeightView: UICollectionViewDelegateFlowLayout {
    
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
        let itemWidth = CGFloat(30)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension WeightView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let indexArr = collectionView.indexPathsForVisibleItems.map({$0[1]})
        let sumOfArr = indexArr.reduce(0, +)
        
//        let indexPath = IndexPath(item: sumOfArr / indexArr.count, section: 0)
//
//        guard let cell = collectionView.cellForItem(at: indexPath) as? WeightViewCell else{
//            return
//        }
//
//        cell.enableHighlight()
    }
}
