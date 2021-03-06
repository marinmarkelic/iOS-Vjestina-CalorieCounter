import CoreData

struct NutritionItemsViewModel: Codable{
    let items: [NutritionItem]
}

struct NutritionItemViewModel: Codable{
    let name: String
    var calories: Float
    var sugar_g: Float
    var fiber_g: Float
    var serving_size_g: Float
    var fat_saturated_g: Float
    var protein_g: Float
    var carbohydrates_total_g: Float
    var fat_total_g: Float
    var sodium_mg: Float
    var potassium_mg: Float
    var cholesterol_mg: Float
    
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
    
    init(_ item: DailyNutritionItemViewModel) {
        name = item.name
        calories = item.calories
        sugar_g = item.sugar_g
        fiber_g = item.fiber_g
        serving_size_g = item.serving_size_g
        fat_saturated_g = item.fat_saturated_g
        protein_g = item.protein_g
        carbohydrates_total_g = item.carbohydrates_total_g
        fat_total_g = item.fat_total_g
        sodium_mg = item.sodium_mg
        potassium_mg = item.potassium_mg
        cholesterol_mg = item.cholesterol_mg
    }
    
    mutating func changeServingSize(servingSize: Float){
        if servingSize == 0{
            print("Tried to change serving size to 0")
            return
        }
        
        let ratio = servingSize / serving_size_g
        
        calories *= ratio
        sugar_g *= ratio
        fiber_g *= ratio
        serving_size_g *= ratio
        fat_saturated_g *= ratio
        protein_g *= ratio
        carbohydrates_total_g *= ratio
        fat_total_g *= ratio
        sodium_mg *= ratio
        potassium_mg *= ratio
        cholesterol_mg *= ratio
    }
    
    func valueForName(name: String) -> Float{
        switch name{
        case "Sugar":
            return sugar_g
        case "Fiber":
            return fiber_g
        case "Protein":
            return protein_g
        case "Carbohydrates":
            return carbohydrates_total_g
        case "Carbs":
            return carbohydrates_total_g
        case "Total Fat":
            return fat_total_g
        default:
            return 0
        }
    }
    
    func getArrayOfNamesForGrams() -> [String]{
        return ["Sugar", "Fiber", "Protein", "Carbohydrates", "Total Fat"]
    }
    
    func getArrayOfValuesForGrams() -> [Float]{
        return [sugar_g, fiber_g, protein_g, carbohydrates_total_g, fat_total_g]
    }
}

struct DailyNutritionViewModel{
    let date: String
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
    
    let items: [DailyNutritionItemViewModel]
    
    init(_ dailyNutrition: DailyNutrition) {
        date = dailyNutrition.date ?? ""
        calories = dailyNutrition.calories
        sugar_g = dailyNutrition.sugar_g
        fiber_g = dailyNutrition.fiber_g
        serving_size_g = dailyNutrition.serving_size_g
        fat_saturated_g = dailyNutrition.fat_saturated_g
        protein_g = dailyNutrition.protein_g
        carbohydrates_total_g = dailyNutrition.carbohydrates_total_g
        fat_total_g = dailyNutrition.fat_total_g
        sodium_mg = dailyNutrition.sodium_mg
        potassium_mg = dailyNutrition.potassium_mg
        cholesterol_mg = dailyNutrition.cholesterol_mg
        
        let itemsSet = dailyNutrition.value(forKey: "items") as? NSSet
        let items = itemsSet?.allObjects as? [DailyNutritionItem]
        
        self.items = items!.map({DailyNutritionItemViewModel($0)})
    }
        
    func getValue(name: String) -> Float{
        switch name{
        case "Protein":
            return protein_g
        case "Total Fat":
            return fat_total_g
        case "Carbs":
            return carbohydrates_total_g
        case "Sugar":
            return sugar_g
        case "Fiber":
            return fiber_g
        default:
            return 0
        }
    }
}

struct DailyNutritionItemViewModel{
    let time: String
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
    
    init(_ dailyNutritionItem: DailyNutritionItem) {
        time = dailyNutritionItem.time ?? ""
        name = dailyNutritionItem.name ?? ""
        calories = dailyNutritionItem.calories
        sugar_g = dailyNutritionItem.sugar_g
        fiber_g = dailyNutritionItem.fiber_g
        serving_size_g = dailyNutritionItem.serving_size_g
        fat_saturated_g = dailyNutritionItem.fat_saturated_g
        protein_g = dailyNutritionItem.protein_g
        carbohydrates_total_g = dailyNutritionItem.carbohydrates_total_g
        fat_total_g = dailyNutritionItem.fat_total_g
        sodium_mg = dailyNutritionItem.sodium_mg
        potassium_mg = dailyNutritionItem.potassium_mg
        cholesterol_mg = dailyNutritionItem.cholesterol_mg
    }
}
