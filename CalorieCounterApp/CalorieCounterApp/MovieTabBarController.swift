import UIKit

class MovieTabBarController: UITabBarController, UITabBarControllerDelegate{
//    var movieSelectedDelegate: MovieSelectedDelegate!
    
    var homeViewController: HomeViewController!
    var mealSearchViewController: MealSearchViewController!
    var userInfoViewController: UserInfoViewController!
    
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
        
        homeViewController = HomeViewController()
        mealSearchViewController = MealSearchViewController()
        userInfoViewController = UserInfoViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "house"), selectedImage: nil)
        mealSearchViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "plus.circle.fill"), selectedImage: nil)
        userInfoViewController.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "slider.horizontal.3"), selectedImage: nil)
        
        viewControllers = [homeViewController, mealSearchViewController, userInfoViewController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
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
