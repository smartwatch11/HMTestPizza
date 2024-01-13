
import UIKit

class MenuViewController: UIViewController {

    var presenter: MenuViewPresenterProtocol!
    
    let header = CustomHeaderViewController()
    var categoryArr: [UIButton] = []
    var menuTableView: UITableView!
    let imagesFetcher = ImagesFetcher()
    var scrollView = UIScrollView()
    var scrollToCat = 0
    
    var height = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewBackgroundColor
        view.addSubview(header.view)
        header.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            header.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            header.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        height = header.view.heightAnchor.constraint(equalToConstant: 230)
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCustomCell
        let item = presenter.items?[indexPath.row]
        cell.itemImageView.image = presenter.images.first(where: {$0.url == item?.imageLink})?.image
        
        cell.itemName.text = item?.name
        cell.itemDesc.text = item?.description
        cell.itemBtn.setTitle("от \(item?.price ?? minimumPrice) р", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        NSLayoutConstraint.deactivate([self.height])
        
        let indexScroll = Int(abs(scrollView.contentOffset.y/180))
        let catId = self.presenter.getCurrentCategory(atIndex: indexScroll)

        if scrollView.contentOffset.y >= 20 {
            self.height.constant = 60
            self.header.view.isHidden = true
            
            if self.scrollToCat != catId {
                categoryBtnTapped(sender: categoryArr[catId], isScrolled: true)
                self.scrollToCat = catId
                self.scrollView.setContentOffset(CGPoint(x: catId*98, y: 0), animated: true)
            }
            
        } else if scrollView.contentOffset.y <= 200 {
            self.height.constant = 230
            self.header.view.isHidden = false
            
            if self.scrollToCat != catId {
                categoryBtnTapped(sender: categoryArr[catId], isScrolled: true)
                self.scrollToCat = catId
                self.scrollView.setContentOffset(CGPoint(x: catId*98, y: 0), animated: true)
            }
        }
        
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.header.view.layoutIfNeeded()
        }, completion: nil)
        
    }
      
}


extension MenuViewController: MenuViewProtocol {
    
    func success() {
        //categories
        scrollView = self.createScroll(conView: header.view)
        view.addSubview(scrollView)
        for i in stride(from: 0, through: presenter.categories!.count-1, by: 1) {
            categoryArr.append(createCategoryBtn(text: presenter.categories![i]))
            
        }
        categoryBtnTapped(sender: categoryArr[0])
        createStackView(arrView: categoryArr, scrollView: scrollView)
        
        
        // menuTableView
        menuTableView = UITableView(frame: .zero, style: .plain)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.backgroundColor = .white
        menuTableView.layer.cornerRadius = 30
        
        self.view.addSubview(menuTableView)
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(MenuCustomCell.self, forCellReuseIdentifier: "menuCell")
        
    }
    
}



