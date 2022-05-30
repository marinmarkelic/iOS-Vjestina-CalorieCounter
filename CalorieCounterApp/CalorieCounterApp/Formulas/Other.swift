func calculateDailyProteinGrams(weight: Float) -> Float{
    return weight * 0.8
}

func calculateDailyFatGrams(calories: Float) -> Float{
    return (calories * 0.3) / 9
}

func calculateDailyCarbsGrams(calories: Float) -> Float{
    return (calories * 0.5) / 4
}

