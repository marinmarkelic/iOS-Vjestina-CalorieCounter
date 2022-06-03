//import ConcentricProgressRingView
//
//class ProgressPieChartTwo: UIView{
//    var ringProgressColor: UIColor = .clear
//    var ringBackgroundColor: UIColor = .lightGray
//    
//    var progressRingView: ConcentricProgressRingView!
//    
//    init() {
//        super.init(frame: .zero)
//        
//        setupChart()
//        addContraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupChart(){
//        let rings = [
//            ProgressRing(color: ringProgressColor, backgroundColor: ringBackgroundColor, width: 4),
//        ]
//        
//        let margin: CGFloat = 2
//        let radius: CGFloat = 20
//        progressRingView = ConcentricProgressRingView(center: center, radius: radius, margin: margin, rings: rings)
//        progressRingView.translatesAutoresizingMaskIntoConstraints = false
//        
//        addSubview(progressRingView)
//    }
//    
//    func addContraints(){
//        progressRingView.snp.makeConstraints{
//            $0.centerX.equalToSuperview().offset(-20)
//            $0.centerY.equalToSuperview().offset(-20)
//        }
//    }
//    
//    func set(progress: Float, color: UIColor){
//        DispatchQueue.main.async{
//            self.progressRingView.arcs[0].setProgress(CGFloat(progress), duration: 1)
//            self.progressRingView.arcs[0].strokeColor = color.cgColor
//        }
//    }
//    
//    
//}
