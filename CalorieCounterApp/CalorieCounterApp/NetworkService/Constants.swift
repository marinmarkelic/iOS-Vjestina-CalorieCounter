let API_KEY = "rB4pVqCmFuAIPKYUunQSmA==qgG9oVfsqrPHsshE"

let GENRE_REQUEST_URL = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=" + API_KEY
let POPULAR_REQUEST_URL = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=" + API_KEY
let TRENDING_REQUEST_URL = "https://api.themoviedb.org/3/trending/movie/week?api_key=" + API_KEY + "&page=1"
let TOPRATED_REQUEST_URL = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=" + API_KEY
let RECOMMENDED_REQUEST_URL = "https://api.themoviedb.org/3/movie/103/recommendations?language=en-US&page=1&api_key=" + API_KEY

let IMAGES_BASE_URL = "https://image.tmdb.org/t/p/original"

func getMovieDetailsUrl(movieId: String) -> String{
    return "https://api.themoviedb.org/3/movie/" + movieId + "?language=en-US&page=1&api_key=" + API_KEY
}


let NUTRITION_DATA_REQUEST_URL = "https://api.calorieninjas.com/v1/nutrition?query="
let API_KEY_HEADER = "X-Api-Key"
