//
//  DailyNutrition+CoreDataProperties.swift
//  CalorieCounterApp
//
//  Created by Marin on 01.06.2022..
//
//

import Foundation
import CoreData


extension DailyNutrition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyNutrition> {
        return NSFetchRequest<DailyNutrition>(entityName: "DailyNutrition")
    }

    @NSManaged public var sugar_g: Float
    @NSManaged public var fiber_g: Float
    @NSManaged public var serving_size_g: Float
    @NSManaged public var sodium_mg: Float
    @NSManaged public var date: String?
    @NSManaged public var potassium_mg: Float
    @NSManaged public var fat_saturated_g: Float
    @NSManaged public var fat_total_g: Float
    @NSManaged public var calories: Float
    @NSManaged public var cholesterol_mg: Float
    @NSManaged public var protein_g: Float
    @NSManaged public var carbohydrates_total_g: Float
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension DailyNutrition {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: DailyNutritionItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: DailyNutritionItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension DailyNutrition : Identifiable {

}
