import UIKit

class Cell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initialize()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() { }
    
    func setupLayout() { }

}

final
class AVFStoreKitHeaderCell: Cell {
    
    var iconURL: URL? {
        didSet {
            iconImageView.load(url: iconURL)
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private
    let titleLabel = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
    }

    private
    let subtitleLabel = UILabel().with {
        $0.textColor = .black
    }

    private
    let iconImageView = UIImageView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .black
    }

    override
    func initialize() {
        contentView.addSubviews(iconImageView, titleLabel, subtitleLabel)
    }

    override
    func setupLayout() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
}

public
extension UIImageView {

    func load(url: URL?) {
        DispatchQueue.global().async { [weak self] in
            guard
                let url = url,
                let data =  try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
