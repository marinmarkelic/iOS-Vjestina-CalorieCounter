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
}

struct NutritionItemGramsViewModel{
    let name: String
    let calories: Float
    let sugar: Float
    let fiber: Float
    let serving_size: Float
    let protein: Float
    let carbohydrates_total: Float
    let fat_total: Float
    let fat_saturated: Float
    
    init(_ nutritionItem: NutritionItem) {
        self.name = nutritionItem.name
        self.calories = nutritionItem.calories
        sugar = nutritionItem.sugar_g
        fiber = nutritionItem.fiber_g
        serving_size = nutritionItem.serving_size_g
        fat_saturated = nutritionItem.fat_saturated_g
        protein = nutritionItem.protein_g
        carbohydrates_total = nutritionItem.carbohydrates_total_g
        fat_total = nutritionItem.fat_total_g
    }
    
    func getArrayOfNames() -> [String]{
        return ["sugar", "fiber", "protein", "carbs", "tfat", "sfat"]
    }
    
    func getArrayOfValues() -> [Float]{
        return [sugar, fiber, protein, carbohydrates_total, fat_total, fat_saturated]
    }
}


