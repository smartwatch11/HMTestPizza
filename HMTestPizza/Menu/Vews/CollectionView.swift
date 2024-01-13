
import UIKit

extension MenuViewController {
    
    func createCategoryBtn(text: String) -> UIButton{
        let btn = UIButton()
        btn.setTitle(text, for: .normal)
        btn.backgroundColor = mainColor02
        btn.layer.cornerRadius = 20
        btn.layer.borderColor = mainColor04.cgColor
        btn.layer.borderWidth = 1
        btn.titleLabel?.font = UIFont.systemFont(ofSize: text.count < 9 ? 16 : 12, weight: .regular)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 98)
        ])
        btn.addTarget(self, action: #selector(categoryBtnTapped), for: .touchUpInside)
        
        return btn
    }
    
    @objc func categoryBtnTapped(sender: UIButton, isScrolled: Bool = false) {
        for btn in self.categoryArr {
            btn.layer.borderWidth = 1
            btn.setTitleColor(mainColor04, for: .normal)
            btn.tintColor = mainColor04
            btn.backgroundColor = UIColor.clear
            btn.layer.borderColor = mainColor04.cgColor
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
        
        sender.layer.borderWidth = 0
        sender.setTitleColor(mainColor, for: .normal)
        sender.backgroundColor = mainColor02
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        if !isScrolled {
            let category = sender.titleLabel?.text
            let id = self.presenter.items?.first(where: {$0.categoryName == category})?.id
            let indexPath = IndexPath(row: id ?? 0, section: 0)
            self.menuTableView?.scrollToRow(at:  indexPath, at: .top, animated: true)
        }
        
    }
    
    func createStackView(arrView: [UIView], scrollView: UIView) {
        let stack = UIStackView(arrangedSubviews: arrView)
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stack.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func createScroll(conView: UIView) -> UIScrollView{
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: conView.bottomAnchor, constant: 24),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scroll.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        return scroll
    }
    
}
