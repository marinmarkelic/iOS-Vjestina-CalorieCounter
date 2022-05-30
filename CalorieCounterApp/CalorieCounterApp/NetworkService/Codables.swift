struct Page: Codable{
    let results: [MovieResult]
}

struct MovieResult: Codable{
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
}

struct MovieDetails: Codable{
    let original_title: String
    let id: Int
    let overview: String
    let backdrop_path: String
    let release_date: String
    let production_countries: [ProductionCountry]
    let genres: [Genre]
    let popularity: Float
    let runtime: Int
}

struct ProductionCountry: Codable{
    let iso_3166_1: String
}

struct Genres: Codable{
    let genres: [Genre]
}

struct Genre: Codable{
    let id: Int
    let name: String
}

struct NutritionItems: Codable{
    let items: [NutritionItem]
}

struct NutritionItem: Codable{
    let name: String
    let calories: Float
    let sugar_g: Float
    let fiber_g: Float
    let serving_size_g: Float
    let fat_saturated_g: Float
    let protein_g: Float
    let carbohydrates_total_g: Float
    let fat_total_g: Float
    let sodium_mg: Float
    let potassium_mg: Float
    let cholesterol_mg: Float
}
