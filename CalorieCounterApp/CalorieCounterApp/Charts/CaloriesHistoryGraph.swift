import ScrollableGraphView
import UIKit
import Foundation

class CaloriesHistoryGraph: ScrollableGraphView{
    
    var linePlotData: [Float]!
    
    convenience init(values: [Float]) {
        self.init(frame: .zero)
        
        dataSource = self
        
        linePlotData = values.reversed()
        
        let linePlot = LinePlot(identifier: "darkLine")
        
        linePlot.lineWidth = 1
        linePlot.lineColor = .white.withAlphaComponent(0.5)
        linePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        linePlot.shouldFill = true
        linePlot.fillType = ScrollableGraphViewFillType.gradient
        linePlot.fillGradientType = ScrollableGraphViewGradientType.linear
        linePlot.fillGradientStartColor = UIColor.clear
        linePlot.fillGradientEndColor = UIColor.clear
        
        linePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        showsHorizontalScrollIndicator = false
        
        
        let dotPlot = DotPlot(identifier: "darkLineDot")
        dotPlot.dataPointSize = 2
        dotPlot.dataPointFillColor = UIColor.white

        dotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        
        let referenceLines = ReferenceLines()

        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white


        referenceLines.positionType = .relative
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        backgroundFillColor = .clear
        
        dataPointSpacing = 80

        shouldAnimateOnStartup = true
        shouldAdaptRange = true
        
        rangeMax = 50
        direction = .leftToRight

        addReferenceLines(referenceLines: referenceLines)

        addPlot(plot: linePlot)
        addPlot(plot: dotPlot)

    }
    
    private func calculateReferenceLines() -> [Double]{
        guard let maxVal = linePlotData.max() else{
            return [0]
        }
        
        let maxValD = Double(maxVal)
        
        return [maxValD / 5.0, maxValD / 4.0, maxValD / 3.0, maxValD / 2.0, maxValD]
    }
    
    func reloadData(_ values: [Float]){
        linePlotData = values.reversed()
        reload()
    }
}

extension CaloriesHistoryGraph: ScrollableGraphViewDataSource{
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "darkLine":
            return Double(linePlotData[pointIndex])
        case "darkLineDot":
            return Double(linePlotData[pointIndex])
        default:
            return 0
        }
    }
    

    func label(atIndex pointIndex: Int) -> String {
        let dateForPoint = Calendar.current.date(byAdding: .day, value: -pointIndex, to: Date.now)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/dd/MM"
        let formattedDate = dateFormatter.string(from: dateForPoint)
                
        let start = formattedDate.index(formattedDate.startIndex, offsetBy: 5)
        let end = formattedDate.index(formattedDate.startIndex, offsetBy: formattedDate.count - 1)
        
        return formattedDate[start...end].replacingOccurrences(of: "/", with: ".").appending(".")
    }

    func numberOfPoints() -> Int {
        return linePlotData.count
    }
}
