import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Pause game or tasks here
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Release shared resources, save data
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Undo changes made on entering background
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart paused tasks
    }
}
