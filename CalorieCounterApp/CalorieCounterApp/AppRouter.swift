import UIKit
class AppRouter: AppRouterProtocol{
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
                
        setupNavigationController()
    }
    
    func setStartScreen(in window: UIWindow?){
        
        
        let movieTabBarController = MovieTabBarController()

        navigationController.pushViewController(movieTabBarController, animated: false)
                
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationController(){
//        navigationController?.navigationBar.backgroundColor = UIColor(red: 11.0/256.0, green: 37.0/256.0, blue: 63.0/256.0, alpha: 1.0)
    }
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}
