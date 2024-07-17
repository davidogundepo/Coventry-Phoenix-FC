import UIKit
import Flutter
import Firebase
import OneSignalFramework
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
    
    lazy var flutterEngine = FlutterEngine(name: "MyApp")
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isStatusBarHidden = false

        // Remove this method to stop OneSignal Debugging
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)

        // OneSignal initialization
        OneSignal.initialize("6b1cda87-62bf-44d0-9243-9088805b7909", withLaunchOptions: launchOptions)

        // No need to request permission here

        flutterEngine.run()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        GeneratedPluginRegistrant.register(with: self.flutterEngine)

        // No need to request permission here

        application.registerForRemoteNotifications()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - MessagingDelegate

    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Check if FIRAuth can handle the notification
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
        // Continue with your notification handling code
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Handle the notification
        completionHandler(UIBackgroundFetchResult.newData)
    }

    // Continue with the rest of your MessagingDelegate methods if needed...
    // ...

    // MARK: - OneSignal Notification Handling (if using Notification Service Extension)

    func didReceiveNotificationExtensionRequest(_ request: UNNotificationRequest, with notificationContent: UNMutableNotificationContent, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        OneSignal.didReceiveNotificationExtensionRequest(request, with: notificationContent, withContentHandler: { newContent in
            contentHandler(newContent)
        })
    }

    // MARK: - UNUserNotificationCenterDelegate (if using Notification Service Extension)

    // Add UNUserNotificationCenterDelegate methods if needed

    // Continue with the rest of your AppDelegate methods...
    // ...
}
