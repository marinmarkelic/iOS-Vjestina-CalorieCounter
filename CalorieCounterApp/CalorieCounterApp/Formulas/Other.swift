func calculateDailyProteinGrams(weight: Float) -> Float{
    return weight * 0.8
}

func calculateDailyFatGrams(calories: Float) -> Float{
    return (calories * 0.3) / 9
}

func calculateDailyCarbsGrams(calories: Float) -> Float{
    return (calories * 0.5) / 4
}

func calculateDailySugarGrams(/*sex: Sex*/) -> Float{
    let sex: Sex = .male
    switch sex {
    case .male:
        return 36
    case .memale:
        return 25
    }
}

func calculateDailyFiberGrams(/*sex: Sex*/) -> Float{
    let sex: Sex = .male
    switch sex {
    case .male:
        return 38
    case .memale:
        return 25
    }
}
