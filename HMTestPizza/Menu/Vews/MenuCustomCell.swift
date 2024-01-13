
import UIKit


class MenuCustomCell: UITableViewCell {
    let itemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let itemName: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        name.numberOfLines = 0
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let itemDesc: UILabel = {
        let desc = UILabel()
        desc.textColor = UIColor(red: 0.665, green: 0.668, blue: 0.679, alpha: 1)
        desc.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        desc.numberOfLines = 0
        desc.translatesAutoresizingMaskIntoConstraints = false
        return desc
    }()
    
    let itemBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 6
        btn.setTitleColor(UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
    }
    
    func setConstraints() {
        self.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            itemImageView.widthAnchor.constraint(equalToConstant: 132),
            itemImageView.heightAnchor.constraint(equalToConstant: 132)
        ])
        
        self.addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            itemName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 180),
            itemName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            itemName.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.addSubview(itemDesc)
        NSLayoutConstraint.activate([
            itemDesc.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 0),
            itemDesc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 180),
            itemDesc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            itemDesc.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.addSubview(itemBtn)
        NSLayoutConstraint.activate([
            itemBtn.topAnchor.constraint(equalTo: itemDesc.bottomAnchor, constant: 8),
            itemBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 264),
            itemBtn.widthAnchor.constraint(equalToConstant: 87),
            itemBtn.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
