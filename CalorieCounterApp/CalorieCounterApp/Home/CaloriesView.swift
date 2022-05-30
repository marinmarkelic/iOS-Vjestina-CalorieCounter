import UIKit
import SnapKit

class CaloriesView: UIView{
    
    var mainView: UIView!
    
    var labelView: UIView!
    var receivedLabel: UILabel!
    var enteredLabel: UILabel!
    var totalLabel: UILabel!
    
    var progressPieChart: ProgressPieChart!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        
        labelView = UIView()
        
        receivedLabel = UILabel()
        receivedLabel.text = "Received"
        receivedLabel.textColor = elementTitleColor
        
        enteredLabel = UILabel()
        enteredLabel.text = "1645"
        enteredLabel.textColor = elementEnteredTextColor
        
        totalLabel = UILabel()
        totalLabel.text = " / 2030 kcal"
        totalLabel.textColor = elementTotalTextColor
        
        progressPieChart = ProgressPieChart()
        configureProgressPieChart()
        
        addSubview(mainView)
        mainView.addSubview(labelView)
        labelView.addSubview(receivedLabel)
        labelView.addSubview(enteredLabel)
        labelView.addSubview(totalLabel)
        mainView.addSubview(progressPieChart)
    }
    
    func configureProgressPieChart(){
        progressPieChart.customizeChart(dataPoints: ["done", "remaining"], values: [1000.0, 250.0])
        progressPieChart.drawEntryLabelsEnabled = false
        progressPieChart.isUserInteractionEnabled = false
        progressPieChart.legend.enabled = false
        progressPieChart.holeRadiusPercent = 0.85
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedText = NSAttributedString(string: "\(Int(250.0/1000.0 * 100))%", attributes: attributes)
        progressPieChart.centerAttributedText = attributedText
        progressPieChart.holeColor = nil
        
        progressPieChart.minOffset = 0
        }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        labelView.snp.makeConstraints{
            $0.top.equalTo(receivedLabel)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(enteredLabel)
            $0.centerY.equalTo(mainView)
        }
        
        receivedLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        
        enteredLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(receivedLabel.snp.bottom)
        }
        
        totalLabel.snp.makeConstraints{
            $0.leading.equalTo(enteredLabel.snp.trailing)
            $0.top.equalTo(enteredLabel)
        }
        
        progressPieChart.snp.makeConstraints{
            $0.top.bottom.equalTo(mainView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(90)
        }
    }
}