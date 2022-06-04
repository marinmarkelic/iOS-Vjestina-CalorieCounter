import UIKit

let appBackgroundColor = UIColor(red: 44/255, green: 44/255, blue: 55/255, alpha: 1)
let elementBackgroundColor = UIColor(red: 29/255, green: 29/255, blue: 36/255, alpha: 1)

let elementTitleColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1)
let elementEnteredTextColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1)
let elementTotalTextColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)

let caloriesColor = UIColor(red: 3/255, green: 244/255, blue: 252/255, alpha: 1)
let proteinColor = UIColor(red: 252/255, green: 3/255, blue: 65/255, alpha: 1)
let sugarColor = UIColor.white
let fiberColor = UIColor(red: 3/255, green: 252/255, blue: 94/255, alpha: 1)
let carbsColor = UIColor(red: 3/255, green: 98/255, blue: 252/255, alpha: 1)
let fatColor = UIColor(red: 252/255, green: 207/255, blue: 3/255, alpha: 1)

func chooseColor(name: String) -> UIColor{
    
    switch name{
    case "Calories":
        return caloriesColor
    case "Protein":
        return proteinColor
    case "Sugar":
        return sugarColor
    case "Fiber":
        return fiberColor
    case "Carbs":
        return carbsColor
    case "Carbohydrates":
        return carbsColor
    case "Total Fat":
        return fatColor
    default:
        return .clear
    }
}

