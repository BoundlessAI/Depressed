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
