import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{
//    var movieSelectedDelegate: MovieSelectedDelegate!
    
    var homeViewController: HomeViewController!
    var searchViewController: SearchViewController!
    var userInfoViewController: UserInfoViewController!
    var favoritesViewController: FavoritesViewController!
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 11.0/256.0, green: 37.0/256.0, blue: 63.0/256.0, alpha: 1.0)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
        homeViewController = HomeViewController()
        searchViewController = SearchViewController()
        userInfoViewController = UserInfoViewController()
        favoritesViewController = FavoritesViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "house"), selectedImage: nil)
        searchViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "plus.circle.fill"), selectedImage: nil)
        favoritesViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "heart"), selectedImage: nil)
        userInfoViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "slider.horizontal.3"), selectedImage: nil)
        
        viewControllers = [homeViewController, searchViewController, favoritesViewController, userInfoViewController]
        
        if checkIfUserDefaultsEmpty(){
            selectedViewController = userInfoViewController
            
        }
    }
    
    func checkIfUserDefaultsEmpty() -> Bool{
        let userDefaults = UserDefaults.standard
                
        if userDefaults.integer(forKey: "height") == 0 || userDefaults.integer(forKey: "weight") == 0{
            return true
        }
        
        return false
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if checkIfUserDefaultsEmpty(){
            selectedViewController = userInfoViewController
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "You have to save your information", message: nil, preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        
        if let vc = viewController as? HomeViewController {
            DispatchQueue.main.async {
                vc.reloadData()
            }
        }
        else if let vc = viewController as? UserInfoViewController {
            DispatchQueue.main.async {
                vc.reloadData()
            }
        }
        else if let vc = viewController as? FavoritesViewController {
            DispatchQueue.main.async {
                vc.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
}
