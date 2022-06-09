import Foundation

class NutritionNetworkDataSource{
        
    func loadNutritionData(itemDescription: String, completionHandler: @escaping (_ nutritionItems: NutritionItems?) -> Void){
        guard let url = URL(string: NUTRITION_DATA_REQUEST_URL + itemDescription.replacingOccurrences(of: " ", with: "+")) else { return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(API_KEY, forHTTPHeaderField: API_KEY_HEADER)
        
        NetworkService().executeUrlRequest(request, completionHandler: {(result: Result<NutritionItems, RequestError>) in
            switch result {
            case .success(let success):
                completionHandler(success)
                
            case .failure(let failure):
                print("Failed to fetch nutrition items:")
                print(failure)
                completionHandler(nil)
            }
        })
    }
}
