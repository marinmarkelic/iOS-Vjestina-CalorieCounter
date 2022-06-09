import UIKit
import SnapKit

class CaloriesView: UIView{
    
    var consumedCalories: Float!
    
    var mainView: UIView!
    
    var labelView: UIView!
    var receivedLabel: UILabel!
    var enteredLabel: UILabel!
    var totalLabel: UILabel!
    
    var progressPieChart: ProgressPieChart!
    
    init(consumedCalories: Float){
        super.init(frame: .zero)
        
        self.consumedCalories = consumedCalories
        
        buildViews()
        addConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(consumedCalories: Float){
        self.consumedCalories = consumedCalories
        
        enteredLabel.text = String(format: "%.1f", consumedCalories)
        totalLabel.text = String(format: " / %.1f kcal", calculateBMR())

        configureProgressPieChart()
        progressPieChart.notifyDataSetChanged()
        progressPieChart.data!.notifyDataChanged()
        progressPieChart.animate(yAxisDuration: 0.5, easingOption: .easeOutCirc)
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = elementBackgroundColor
        mainView.layer.cornerRadius = 8
        
        labelView = UIView()
        
        receivedLabel = UILabel()
        receivedLabel.text = "Consumed"
        receivedLabel.textColor = elementTitleColor
        
        enteredLabel = UILabel()
        enteredLabel.text = String(format: "%.1f", consumedCalories)
        enteredLabel.textColor = elementEnteredTextColor
        
        totalLabel = UILabel()
        totalLabel.text = String(format: " / %.1f kcal", calculateBMR())
        totalLabel.textColor = elementTitleColor
        
        progressPieChart = ProgressPieChart()
        progressPieChart.setColor(color: chooseColor(name: "Calories"))
        configureProgressPieChart()
        
        addSubview(mainView)
        mainView.addSubview(labelView)
        labelView.addSubview(receivedLabel)
        labelView.addSubview(enteredLabel)
        labelView.addSubview(totalLabel)
        mainView.addSubview(progressPieChart)
    }
    
    func configureProgressPieChart(){
        let secondValue: Double
        if consumedCalories / calculateBMR() > 1{
            secondValue = 0
        }
        else{
            secondValue = Double(calculateBMR() - consumedCalories)
        }
        
        progressPieChart.animate(xAxisDuration: 0.5, easingOption: .easeInCirc)
        progressPieChart.customizeChart(dataPoints: ["done", "remaining"], values: [Double(consumedCalories), secondValue])
        progressPieChart.drawEntryLabelsEnabled = false
        progressPieChart.isUserInteractionEnabled = false
        progressPieChart.legend.enabled = false
        progressPieChart.holeRadiusPercent = 0.85
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedText = NSAttributedString(string: "\(Int(consumedCalories / calculateBMR() * 100))%", attributes: attributes)
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
