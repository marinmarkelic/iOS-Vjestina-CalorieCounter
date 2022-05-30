

class NutritionRepository{
    
    var networkDataSource: NutritionNetworkDataSource!
    var databaseDataSource: NutritionDatabaseDataSource!
    
    init() {
        networkDataSource = NutritionNetworkDataSource()
        databaseDataSource = NutritionDatabaseDataSource()
    }
    
    func loadNutritionData(itemDescription: String, completionHandler: @escaping (_: NutritionItemViewModel) -> Void){
        networkDataSource.loadNutritionData(itemDescription: "egg"){
            guard let items = $0 else{
                return
            }
            
            completionHandler(NutritionItemViewModel(items.items.first!))
        }
    }
    
}
