struct NutritionItemsViewModel: Codable{
    let items: [NutritionItem]
}

struct NutritionItemViewModel: Codable{
    let name: String
    let calories: Float
    let sugar_g: Float
    let fiber_g: Float
    let serving_size_g: Float
    let fat_saturated_g: Float
    let protein_g: Float
    let carbohydrates_total_g: Float
    let fat_total_g: Float
    let sodium_mg: Float
    let potassium_mg: Float
    let cholesterol_mg: Float
    
    init(_ nutritionItem: NutritionItem) {
        name = nutritionItem.name
        calories = nutritionItem.calories
        sugar_g = nutritionItem.sugar_g
        fiber_g = nutritionItem.fiber_g
        serving_size_g = nutritionItem.serving_size_g
        fat_saturated_g = nutritionItem.fat_saturated_g
        protein_g = nutritionItem.protein_g
        carbohydrates_total_g = nutritionItem.carbohydrates_total_g
        fat_total_g = nutritionItem.fat_total_g
        sodium_mg = nutritionItem.sodium_mg
        potassium_mg = nutritionItem.potassium_mg
        cholesterol_mg = nutritionItem.cholesterol_mg
    }
    
    func getArrayOfNamesForGrams() -> [String]{
        return ["sugar", "fiber", "protein", "carbs", "tfat"]
    }
    
    func getArrayOfValuesForGrams() -> [Float]{
        return [sugar_g, fiber_g, protein_g, carbohydrates_total_g, fat_total_g]
    }
}