func calculateBMR(weight_kg: Float, height_cm: Float, age: Int, sex: Sex) -> Float{
    switch sex {
    case .male:
        return 66.5 + (13.75 * weight_kg) + (5.003 * height_cm) - (6.75 * Float(age))
    case .memale:
        return 655.1 + (9.563 * weight_kg) + (1.850 * height_cm) - (4.676 * Float(age))
    }
}

func getMockBMR() -> Float{
    return calculateBMR(weight_kg: 81, height_cm: 184, age: 21, sex: .male)
}

enum Sex{
    case male;
    case memale;
}
