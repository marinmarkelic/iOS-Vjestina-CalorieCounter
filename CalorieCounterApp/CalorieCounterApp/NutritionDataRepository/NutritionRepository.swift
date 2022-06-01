

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
    
    func fetchDailyNutrition() -> DailyNutritionViewModel?{
        return DailyNutritionViewModel(databaseDataSource.loadDailyNutrition())
    }
    
    func addItem(_ item: NutritionItemViewModel, completionHandler: (Bool) -> Void){
        print("adding item repo")
        let result = databaseDataSource.addDailyNutritionItem(item: item)
        
        completionHandler(result)
    }
    
}
