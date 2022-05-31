

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
    
    func addItem(_ item: NutritionItemViewModel){
        
    }
    
}
