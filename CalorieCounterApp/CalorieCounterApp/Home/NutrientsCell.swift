import UIKit
import SnapKit
import Charts

class NutrientsCell: UICollectionViewCell{
    static let reuseIdentifier = String(describing: NutrientsView.self)
    
    var name: UILabel!
    var value: Float!
    
    var progressPieChart: ProgressPieChart!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, value: Float){
        self.name.text = name
        self.value = value
                
        progressPieChart.setColor(color: chooseColor(name: name))
        
        configureProgressPieChart()
        progressPieChart.notifyDataSetChanged()
        progressPieChart.data!.notifyDataChanged()
        progressPieChart.animate(yAxisDuration: 0.5, easingOption: .easeOutCirc)
    }
    
    func buildViews(){
        backgroundColor = elementBackgroundColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        name = UILabel()
        name.textAlignment = .center
        name.textColor = elementEnteredTextColor
        
        progressPieChart = ProgressPieChart()
        
        
        addSubview(name)
        addSubview(progressPieChart)
    }
    
    func configureProgressPieChart(){
        let secondValue: Double
        if value ?? 0 / chooseFormula(name: name.text!) > 100{
            secondValue = 0
        }
        else{
            secondValue = Double(100 - value)
        }
        
        progressPieChart.customizeChart(dataPoints: ["done", "remaining"], values: [Double(value), secondValue])
        progressPieChart.drawEntryLabelsEnabled = false
        progressPieChart.isUserInteractionEnabled = false
        progressPieChart.legend.enabled = false
        progressPieChart.holeRadiusPercent = 0.85
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedText = NSAttributedString(string: "\(Int(value ?? 0 / chooseFormula(name: name.text!)))%", attributes: attributes)
        progressPieChart.centerAttributedText = attributedText
        progressPieChart.holeColor = nil
        
        progressPieChart.minOffset = 0
    }
    
    func chooseFormula(name: String) -> Float{
        switch name{
        case "Protein":
            return calculateDailyProteinGrams()
        case "Total Fat":
            return calculateDailyFatGrams(calories: calculateBMR())
        case "Carbs":
            return calculateDailyCarbsGrams(calories: calculateBMR())
        case "Sugar":
            return calculateDailySugarGrams()
        case "Fiber":
            return calculateDailyFiberGrams()
        default:
            return 0
        }
    }
    
    func addConstraints(){
        name.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        progressPieChart.snp.makeConstraints{
            $0.top.equalTo(name.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }

    }
}
