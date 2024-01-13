
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar(menuView: buildScene())
    }
    
    func buildScene() -> UIViewController {
        let menuView = MenuViewController()
        let apiHandler = ApiFetchHandler()
        let imageFetcher = ImagesFetcher()
        let presenter = MenuPresenter(view: menuView, apiHandler: apiHandler, imageFetcher: imageFetcher)
        menuView.presenter = presenter
        return menuView
    }
    
    func setupTabBar(menuView: UIViewController) {
        let menu = createNavController(vc: menuView, itemName: "Меню", itemImage: UIImage(named: "menu.svg")!)
        let contacts = createNavController(vc: ContactsViewController(), itemName: "Контакты", itemImage: UIImage(named: "contacts.svg")!)
        let profile = createNavController(vc: ProfileViewController(), itemName: "Профиль", itemImage: UIImage(named: "profile.svg")!)
        let basket = createNavController(vc: BasketViewController(), itemName: "Корзина", itemImage: UIImage(named: "basket.svg")!)
    
        viewControllers = [menu, contacts, profile, basket]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: itemImage.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)

        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        item.standardAppearance = appearance
        item.scrollEdgeAppearance = item.standardAppearance
        
        return navController
    }


}
