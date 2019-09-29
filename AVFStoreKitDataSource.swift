import UIKit

private
enum AVFStoreKitData: Int {

    case header, raiting, screenshots, iPadOffers, desription, developerPage, raitingsAndReviewTitle, raitingsDetail, reviewCarousel, infoSectionTitle, seller, size, category, compability, languages, ageRaiting, devWebsite, license
    
    var cellID: String {
        switch self {
        case .header:
            return "headerCell"
        default:
            return String()
        }
    }
}

extension AVFStoreKitVC: UITableViewDataSource {

    public
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = AVFStoreKitData(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        switch data {
        case .header:
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: data.cellID) as? AVFStoreKitHeaderCell else {
                return UITableViewCell()
            }
            headerCell.title = config.title
            headerCell.iconURL = config.iconURL
            return headerCell
        default:
            return UITableViewCell()
        }
    }

}

extension AVFStoreKitVC: UITableViewDelegate {

    public
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    public
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

}
