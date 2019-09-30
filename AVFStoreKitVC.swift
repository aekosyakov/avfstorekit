import UIKit
import DailyUtils

//        Example:
//        let avfStoreKitConfig = AVFStoreKitConfig()
//        avfStoreKitConfig.appId = "1013279592"
//        avfStoreKitConfig.overrideParms = ["title": "Geometry", "subtitle": "Architecture around you", "iconURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAA8qJDxryT5VxBN7NbLXDQ_BqWJHtSK74UqlUFlGK2A5c6vU3"]
//        avfStoreKitConfig.updateData { error in
//            guard error == nil else {
//                return
//            }
//            let vc = AVFStoreKitVC(config: avfStoreKitConfig)
//            vc.action = { print($0) }
//            self.present(vc, animated: true, completion: nil)
//        }


public
enum AVFStoreKitAction {
    
    public
    enum ScrollType {
        case screenshots, reviews
    }
    case get, dots, scroll(type: ScrollType, page: Int), more, seeAll, close

}



final public
class AVFStoreKitVC: UIViewController {

    let config: AVFStoreKitConfig
    
    var action: ((AVFStoreKitAction) -> Void)?

    private lazy
    var tableView = UITableView().with {
        $0.dataSource = self
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    public override
    func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(AVFStoreKitHeaderCell.self, forCellReuseIdentifier: "headerCell")
        setupLayout()
    }

    private
    func setupLayout() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ]
        )
    }

    init(config: AVFStoreKitConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
