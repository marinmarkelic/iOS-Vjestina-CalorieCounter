func calculateDailyProteinGrams(weight: Float) -> Float{
    return weight * 0.8
}

func calculateDailyFatGrams(calories: Float) -> Float{
    return (calories * 0.3) / 9
}

func calculateDailyCarbsGrams(calories: Float) -> Float{
    return (calories * 0.5) / 4
}

func calculateDailySugarGrams(/*gender: gender*/) -> Float{
    let gender: Gender = .male
    switch gender {
    case .male:
        return 36
    case .female:
        return 25
    }
}

func calculateDailyFiberGrams(/*gender: gender*/) -> Float{
    let gender: Gender = .male
    switch gender {
    case .male:
        return 38
    case .female:
        return 25
    }
}
