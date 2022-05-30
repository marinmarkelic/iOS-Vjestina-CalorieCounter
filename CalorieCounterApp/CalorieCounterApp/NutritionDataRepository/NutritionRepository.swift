

class NutritionRepository{
    
    var networkDataSource: NutritionNetworkDataSource!
    var databaseDataSource: NutritionDatabaseDataSource!
    
    init() {
        networkDataSource = NutritionNetworkDataSource()
        databaseDataSource = NutritionDatabaseDataSource()
    }
    
    func loadNutritionData(itemDescription: String, completionHandler: @escaping (_: NutritionItemGramsViewModel) -> Void){
        networkDataSource.loadNutritionData(itemDescription: "carrot"){
            guard let items = $0 else{
                return
            }
            
            print(NutritionItemGramsViewModel(items.items.first!))
            completionHandler(NutritionItemGramsViewModel(items.items.first!))
        }
    }
    
}
