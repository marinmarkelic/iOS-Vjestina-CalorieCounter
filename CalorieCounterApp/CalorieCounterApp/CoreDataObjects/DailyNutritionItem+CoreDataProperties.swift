//
//  DailyNutritionItem+CoreDataProperties.swift
//  CalorieCounterApp
//
//  Created by Marin on 31.05.2022..
//
//

import Foundation
import CoreData


extension DailyNutritionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyNutritionItem> {
        return NSFetchRequest<DailyNutritionItem>(entityName: "DailyNutritionItem")
    }

    @NSManaged public var sugar_g: Float
    @NSManaged public var fiber_g: Float
    @NSManaged public var serving_size_g: Float
    @NSManaged public var sodium_mg: Float
    @NSManaged public var name: String?
    @NSManaged public var potassium_mg: Float
    @NSManaged public var fat_saturated_g: Float
    @NSManaged public var fat_total_g: Float
    @NSManaged public var calories: Float
    @NSManaged public var cholesterol_mg: Float
    @NSManaged public var protein_g: Float
    @NSManaged public var carbohydrates_total_g: Float
    @NSManaged public var dailyNutrition: DailyNutrition?

}

extension DailyNutritionItem : Identifiable {

}
