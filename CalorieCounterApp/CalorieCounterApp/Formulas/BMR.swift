import UIKit

func calculateBMR(weight_kg: Float, height_cm: Float, age: Int, gender: Gender) -> Float{
    
    switch gender {
    case .male:
        return 66.5 + (13.75 * weight_kg) + (5.003 * height_cm) - (6.75 * Float(age))
    case .female:
        return 655.1 + (9.563 * weight_kg) + (1.850 * height_cm) - (4.676 * Float(age))
    }
}

func calculateBMR() -> Float{
    let userDefaults = UserDefaults.standard
    
    let gender = userDefaults.integer(forKey: "gender")
    let height = userDefaults.integer(forKey: "height")
    let weight = userDefaults.integer(forKey: "weight")
    let age = 21
    
    switch Gender(rawValue: Int(gender)) {
    case .male:
        return Float(66.5 + (13.75 * Float(weight)) + (5.003 * Float(height))) - (6.75 * Float(age))
    case .female:
        return 655.1 + (9.563 * Float(weight)) + (1.850 * Float(height)) - (4.676 * Float(age))
    default:
        return 0
    }
}

func getMockBMR() -> Float{
    return calculateBMR(weight_kg: 81, height_cm: 184, age: 21, gender: .male)
}

enum Gender: Int{
    case male;
    case female;
}
