//
//  Favorites+CoreDataProperties.swift
//  
//
//  Created by Marin on 08.06.2022..
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var favoriteItems: NSSet?

}

// MARK: Generated accessors for favoriteItems
extension Favorites {

    @objc(addFavoriteItemsObject:)
    @NSManaged public func addToFavoriteItems(_ value: DailyNutritionItem)

    @objc(removeFavoriteItemsObject:)
    @NSManaged public func removeFromFavoriteItems(_ value: DailyNutritionItem)

    @objc(addFavoriteItems:)
    @NSManaged public func addToFavoriteItems(_ values: NSSet)

    @objc(removeFavoriteItems:)
    @NSManaged public func removeFromFavoriteItems(_ values: NSSet)

}
