import CoreData

class NutritionDatabaseDataSource{
    var coreDataStack: CoreDataStack!
    var managedContext: NSManagedObjectContext!
    
    init(){
        coreDataStack = CoreDataStack()
        managedContext = coreDataStack.persistentContainer.viewContext
    }
    
    func addDailyNutritionItem(item: NutritionItemViewModel) -> Bool{
        print("adding item DS")
        var dailyNutrition: DailyNutrition
        
        if fetchDailyNutrition() == nil{
            let entity = NSEntityDescription.entity(forEntityName: "DailyNutrition", in: managedContext)!
            dailyNutrition = DailyNutrition(entity: entity, insertInto: managedContext)
            
            print("created new daily nutrition")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            dailyNutrition.date = dateFormatter.string(from: Date())
            
//            dailyNutrition.date = Date().formatted(date: .numeric, time: .omitted)
        }
        else{
            dailyNutrition = fetchDailyNutrition()!
            print("fetched existing daily nutrition")
        }

        
        dailyNutrition.sugar_g += item.sugar_g
        dailyNutrition.fiber_g += item.fiber_g
        dailyNutrition.sodium_mg += item.sodium_mg
        dailyNutrition.potassium_mg += item.potassium_mg
        dailyNutrition.fat_saturated_g += item.fat_saturated_g
        dailyNutrition.fat_total_g += item.fat_total_g
        dailyNutrition.calories += item.calories
        dailyNutrition.cholesterol_mg += item.cholesterol_mg
        dailyNutrition.protein_g += item.protein_g
        dailyNutrition.carbohydrates_total_g += item.carbohydrates_total_g
        
        
        let entity = NSEntityDescription.entity(forEntityName: "DailyNutritionItem", in: managedContext)!
        let dailyNutritionItem = DailyNutritionItem(item: item, entity: entity, insertInto: managedContext)
        dailyNutrition.addToItems(dailyNutritionItem)
        
        do{
            try managedContext.save()
            return true
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return false
        }
    }
    
    func loadDailyNutrition() -> DailyNutrition{
        var dailyNutrition: DailyNutrition
        
        if fetchDailyNutrition() == nil{
            let entity = NSEntityDescription.entity(forEntityName: "DailyNutrition", in: managedContext)!
            dailyNutrition = DailyNutrition(entity: entity, insertInto: managedContext)
            
            print("created new daily nutrition")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            dailyNutrition.date = dateFormatter.string(from: Date())
            
//            dailyNutrition.date = Date().formatted(date: .numeric, time: .omitted)
        }
        else{
            dailyNutrition = fetchDailyNutrition()!
            print("fetched existing daily nutrition")
        }
        
        try? managedContext.save()
        return dailyNutrition
    }
    
    func fetchDailyNutrition() -> DailyNutrition?{
        let fetchRequest = DailyNutrition.fetchRequest()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.string(from: Date())
        
        let predicate = NSPredicate(format: "date = %@", "\(date)")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do{
            return try managedContext.fetch(fetchRequest).first
        }catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return nil
        }
    }
    
    func fetchAllDailyNutritionItems() -> [DailyNutritionItem]?{
        guard let dailyNutrition = fetchDailyNutrition() else{
            return nil
        }
        
        let itemsSet = dailyNutrition.value(forKey: "items") as? NSSet
        let items = itemsSet?.allObjects as? [DailyNutritionItem]
        
        return items
    }
    
    func deleteDailyNutritionItem(name: String, time: String, servingSize: Float){
        guard let dailyNutrition = fetchDailyNutrition() else{
            print("Failed to fetch DN in delete item")
            return
        }
        
        let itemsSet = dailyNutrition.value(forKey: "items") as? NSSet
        let items = itemsSet?.allObjects as? [DailyNutritionItem]
        
        guard let items = items else{
            return
        }
        
        if items.isEmpty{
            return
        }
        
        let item = items[0]
        
        dailyNutrition.sugar_g -= item.sugar_g
        dailyNutrition.fiber_g -= item.fiber_g
        dailyNutrition.sodium_mg -= item.sodium_mg
        dailyNutrition.potassium_mg -= item.potassium_mg
        dailyNutrition.fat_saturated_g -= item.fat_saturated_g
        dailyNutrition.fat_total_g -= item.fat_total_g
        dailyNutrition.calories -= item.calories
        dailyNutrition.cholesterol_mg -= item.cholesterol_mg
        dailyNutrition.protein_g -= item.protein_g
        dailyNutrition.carbohydrates_total_g -= item.carbohydrates_total_g
        
        dailyNutrition.removeFromItems(item)
        try? managedContext.save()
    }
    
    func fetchAllDailyNutrition() -> [DailyNutrition]?{
        let fetchRequest = DailyNutrition.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            return try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return nil
        }
    }
    
    func del(){
        managedContext.reset()

        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyNutrition")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch _ as NSError {
            return
        }

        fetchRequest = NSFetchRequest(entityName: "DailyNutritionItem")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch _ as NSError {
            return
        }

        try? managedContext.save()
    }
}
