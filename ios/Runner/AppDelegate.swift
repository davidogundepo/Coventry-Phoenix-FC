import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
    
    lazy var flutterEngine = FlutterEngine(name: "MyApp")
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    UIApplication.shared.isStatusBarHidden = false
      
      flutterEngine.run()
      FirebaseApp.configure()
      
      Messaging.messaging().delegate = self
      
      GeneratedPluginRegistrant.register(with: self.flutterEngine)
      
      if #available(iOS 10.0, *) {
              // For iOS 10 display notification (sent via APNS)
              UNUserNotificationCenter.current().delegate = self
              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                      options: authOptions,
                      completionHandler: {_, _ in })
          } else {
              let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
          }
          application.registerForRemoteNotifications()
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
