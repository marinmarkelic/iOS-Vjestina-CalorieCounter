

class NutritionRepository{
    
    var networkDataSource: NutritionNetworkDataSource!
    var databaseDataSource: NutritionDatabaseDataSource!
    
    init() {
        networkDataSource = NutritionNetworkDataSource()
        databaseDataSource = NutritionDatabaseDataSource()
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
    
    func fetchDailyNutrition() -> DailyNutritionViewModel?{
        guard let dailyNutrition = databaseDataSource.fetchDailyNutrition() else{
            return nil
        }
        
        return DailyNutritionViewModel(dailyNutrition)
    }
    
    func addItem(_ item: NutritionItemViewModel, completionHandler: (Bool) -> Void){
        print("adding item repo")
        let result = databaseDataSource.addDailyNutritionItem(item: item)
        
        completionHandler(result)
    }
    
}
