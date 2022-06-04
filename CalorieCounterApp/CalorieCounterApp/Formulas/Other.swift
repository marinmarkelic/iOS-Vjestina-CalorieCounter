import UIKit

func calculateDailyProteinGrams() -> Float{
    let userDefaults = UserDefaults.standard
    let weight = userDefaults.integer(forKey: "weight")

    return Float(weight) * 0.8
}

func calculateDailyFatGrams(calories: Float) -> Float{
    return (calories * 0.3) / 9
}

func calculateDailyCarbsGrams(calories: Float) -> Float{
    return (calories * 0.5) / 4
}

func calculateDailySugarGrams(/*gender: gender*/) -> Float{
    let userDefaults = UserDefaults.standard
    let gender = userDefaults.integer(forKey: "gender")
    
    switch Gender(rawValue: gender) {
    case .male:
        return 36
    case .female:
        return 25
    default:
        return 0
    }
}

func calculateDailyFiberGrams(/*gender: gender*/) -> Float{
    let userDefaults = UserDefaults.standard
    let gender = userDefaults.integer(forKey: "gender")
    
    switch Gender(rawValue: gender) {
    case .male:
        return 38
    case .female:
        return 25
    default:
        return 0
    }
}
