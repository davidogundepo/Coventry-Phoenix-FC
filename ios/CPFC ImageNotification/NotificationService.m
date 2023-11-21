// NotificationService.m

#import "NotificationService.h"
#import <FirebaseAuth.h>
#import "FirebaseMessaging.h"
#import <OneSignalFramework/OneSignalFramework.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNNotificationRequest *receivedRequest;
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

// Remove these methods if not used for Firebase Authentication
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    if ([[FIRAuth auth] canHandleURL:url]) {
        return YES;
    }
    // URL not auth-related; it should be handled separately.
    return NO;
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    for (UIOpenURLContext *urlContext in URLContexts) {
        [FIRAuth.auth canHandleURL:urlContext.URL];
        // URL not auth related; it should be handled separately.
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Use FIRAuthAPNSTokenTypeSandbox if the entitlement is set to development
    [[FIRAuth auth] setAPNSToken:deviceToken type:FIRAuthAPNSTokenTypeSandbox];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if ([[FIRAuth auth] canHandleNotification:notification]) {
        completionHandler(UIBackgroundFetchResultNoData);
        return;
    }
}

// Main method for handling notification requests
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.receivedRequest = request;
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];

    // Handle OneSignal notification request
    [OneSignal didReceiveNotificationExtensionRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent withContentHandler:self.contentHandler];

    // Handle Firebase Messaging notification request
    [[FIRMessaging extensionHelper] populateNotificationContent:self.bestAttemptContent withContentHandler:contentHandler];
}

// Called just before the extension will be terminated by the system
- (void)serviceExtensionTimeWillExpire {
    // Use this as an opportunity to deliver your "best attempt" at modified content
    [OneSignal serviceExtensionTimeWillExpireRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent];
    self.contentHandler(self.bestAttemptContent);
}

@end
