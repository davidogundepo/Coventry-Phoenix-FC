import UIKit
import Flutter
import Firebase
import OneSignal
//import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate  {
    
    lazy var flutterEngine = FlutterEngine(name: "MyApp")
    
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
      UIApplication.shared.isStatusBarHidden = false
      
      // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        // OneSignal initialization
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("6b1cda87-62bf-44d0-9243-9088805b7909")
        
        // promptForPushNotifications will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
      
//     (BOOL)prefersStatusBarHidden {
//
//        return NO;
//     }
      
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
