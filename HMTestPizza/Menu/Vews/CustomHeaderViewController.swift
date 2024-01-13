
import UIKit

class CustomHeaderViewController: UIViewController {
    var menuButton = dropDownBtn()
    let banners = ["1", "2","3", "4"]
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        //dropDownMenu
        menuButton = dropDownBtn(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.dropView.dropDownOptions = cities
        menuButton.setTitle(menuButton.dropView.dropDownOptions[0] + " ", for: .normal)
        menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        menuButton.setImage(UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(weight: .medium)), for: .normal)

        //banners
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 115)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(menuButton)
        
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            menuButton.widthAnchor.constraint(equalToConstant: 180),
            menuButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


extension CustomHeaderViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.bannerImageView.image = UIImage(named: banners[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout , sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-50), height: 112)
    }
    
}

class CustomCell: UICollectionViewCell {
    let bannerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bannerImageView)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        bannerImageView.layer.cornerRadius = 10
        bannerImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
