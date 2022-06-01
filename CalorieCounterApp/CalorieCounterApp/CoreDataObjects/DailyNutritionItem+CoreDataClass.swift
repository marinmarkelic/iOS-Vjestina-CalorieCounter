//
//  DailyNutritionItem+CoreDataClass.swift
//  CalorieCounterApp
//
//  Created by Marin on 01.06.2022..
//
//

import Foundation
import CoreData

@objc(DailyNutritionItem)
public class DailyNutritionItem: NSManagedObject {
    convenience init(item: NutritionItemViewModel, entity: NSEntityDescription, insertInto context: NSManagedObjectContext!) {
        self.init(entity: entity, insertInto:  context)
        
        self.sugar_g = item.sugar_g
        self.fiber_g = item.fiber_g
        self.serving_size_g = item.serving_size_g
        self.sodium_mg = item.sodium_mg
        self.name = item.name
        self.potassium_mg = item.potassium_mg
        self.fat_saturated_g = item.fat_saturated_g
        self.fat_total_g = item.fat_total_g
        self.calories = item.calories
        self.cholesterol_mg = item.cholesterol_mg
        self.protein_g = item.protein_g
        self.carbohydrates_total_g = item.carbohydrates_total_g
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.time = dateFormatter.string(from: Date())
    }
}
