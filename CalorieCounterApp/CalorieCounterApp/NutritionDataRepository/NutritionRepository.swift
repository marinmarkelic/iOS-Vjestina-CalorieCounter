

class NutritionRepository{
    
    var networkDataSource: NutritionNetworkDataSource!
    var databaseDataSource: NutritionDatabaseDataSource!
    
    init() {
        networkDataSource = NutritionNetworkDataSource()
        databaseDataSource = NutritionDatabaseDataSource()
        
//        databaseDataSource.del()
    }
    
    func loadNutritionData(itemDescription: String, completionHandler: @escaping (_: NutritionItemViewModel) -> Void){
        networkDataSource.loadNutritionData(itemDescription: itemDescription){
            guard let items = $0,
            let first = items.items.first else{
                return
            }
            
            completionHandler(NutritionItemViewModel(first))
        }
    }
    
    
    func fetchAllDailyNutrition() -> [DailyNutritionViewModel]?{
        guard let data = databaseDataSource.fetchAllDailyNutrition() else{
            return nil
        }
        
        var dailyNutritionViewModelArr: [DailyNutritionViewModel] = []
        for i in data{
            dailyNutritionViewModelArr.append(DailyNutritionViewModel(i))
        }
        
        return dailyNutritionViewModelArr
    }
    
    func countAllDailyNutrition() -> Int{
        guard let data = databaseDataSource.fetchAllDailyNutrition() else{
            return 0
        }
        
        return data.count
    }
    
    func fetchAllDailyNutritionCalories() -> [Float]{
        guard let data = databaseDataSource.fetchAllDailyNutrition() else{
            return [0.0]
        }
        
        return data.map({
            let d = $0 as DailyNutrition
            return d.value(forKey: "calories") as? Float ?? 0
        })
    }
    
    func fetchDailyNutrition() -> DailyNutritionViewModel?{
        return DailyNutritionViewModel(databaseDataSource.loadDailyNutrition())
    }
    
    func deleteItem(_ item: DailyNutritionItemViewModel){
        databaseDataSource.deleteDailyNutritionItem(name: item.name, time: item.time, servingSize: item.serving_size_g)
    }
    
    func addItem(_ item: NutritionItemViewModel, completionHandler: (Bool) -> Void){
        print("adding item repo")
        let result = databaseDataSource.addDailyNutritionItem(item: item)
        
        completionHandler(result)
    }
    
}
