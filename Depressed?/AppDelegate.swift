import UIKit
import Sesame

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Appearance.setUp()

        Sesame.shared = .init(
            appId: SesameProperties.file.appId,
            auth: SesameProperties.file.auth,
            versionId: SesameProperties.file.versionId,
            userId: SesameProperties.file.userId
        )

        return true
    }

}

struct SesameProperties {
    static let file: SesameProperties = {
        guard let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
            let apiKeys = NSDictionary(contentsOfFile: path) as? [String: Any],
            let sesameKeys = apiKeys["Sesame"] as? [String: String],
            let sesameProperties = SesameProperties(dict: sesameKeys)
            else { fatalError() }
        return sesameProperties
    }()

    let appId: String
    let auth: String
    let versionId: String
    let userId: String

    init?(dict: [String: Any]) {
        guard let appId = dict["appId"] as? String, !appId.isEmpty,
            let auth = dict["auth"] as? String, !auth.isEmpty,
            let versionId = dict["versionId"] as? String, !versionId.isEmpty,
            let userId = dict["userId"] as? String, !userId.isEmpty
            else { return nil }
        self.appId = appId
        self.auth = auth
        self.versionId = versionId
        self.userId = userId
    }
}
