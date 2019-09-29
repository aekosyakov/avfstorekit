import Foundation

private
let baseURL = "https://itunes.apple.com/lookup?id="

final public
class AVFStoreKitConfig : NSObject {

    public
    var appId: String?  {
        didSet {
            updateData()
        }
    }

    public
    var locale: String?

    public
    var overrideParms: [String: Any]?

    fileprivate
    var responseDict: [String: Any]?

    override public init() { }

}

extension AVFStoreKitConfig {
    
    func updateData(completion: ((Error?) -> Void)? = nil) {
        guard let appID = appId, let url = URL(string: baseURL.appending(appID)) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion?(error)
                return
            }
            self.responseDict = jsonResponse?.merging(self.overrideParms ?? [:]) { $1 }
            completion?(nil)
        }.resume()
    }
    
    var title: String? {
        return responseDict?.string(for: "title", locale: locale)
    }
    
    var subtitle: String? {
        return responseDict?.string(for: "subttle", locale: locale)
    }
    
    var iconURL: URL? {
        guard let urlString = responseDict?.string(for: "iconURL", locale: locale) else {
            return nil
        }
        return URL(string: urlString)
    }
    
}
