//
//  NotificationService.m
//  CPFC ImageNotification
//
//  Created by David OGUNDEPO on 02/08/2022.
//

#import "NotificationService.h"
//#import <FirebasdseAuth/FirebaseAuth.h>
#import <FirebaseAuth.h>
#import "FirebaseMessaging.h"
#import <OneSignalFramework/OneSignalFramework.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNNotificationRequest *receivedRequest;
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService


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




- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  // I used type:FIRAuthAPNSTokenTypeSandbox as the entitlement is set to development
  [[FIRAuth auth] setAPNSToken:deviceToken type:FIRAuthAPNSTokenTypeSandbox];
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)notification
          fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  if ([[FIRAuth auth] canHandleNotification:notification]) {
    completionHandler(UIBackgroundFetchResultNoData);
    return;
  }
}




- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.receivedRequest = request;
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    
    //If your SDK version is < 3.5.0 uncomment and use this code:
        /*
        [OneSignal didReceiveNotificationExtensionRequest:self.receivedRequest
                           withMutableNotificationContent:self.bestAttemptContent];
        self.contentHandler(self.bestAttemptContent);
        */
        
        /* DEBUGGING: Uncomment the 2 lines below and comment out the one above to ensure this extension is excuting
                      Note, this extension only runs when mutable-content is set
                      Setting an attachment or action buttons automatically adds this */
        // NSLog(@"Running NotificationServiceExtension");
        // self.bestAttemptContent.body = [@"[Modified] " stringByAppendingString:self.bestAttemptContent.body];
        
        // Uncomment this line to set the default log level of NSE to VERBOSE so we get all logs from NSE logic
        //[OneSignal setLogLevel:ONE_S_LL_VERBOSE visualLevel:ONE_S_LL_NONE];
        [OneSignal didReceiveNotificationExtensionRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent withContentHandler:self.contentHandler];


    
    
    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//
//    self.contentHandler(self.bestAttemptContent);
    [[FIRMessaging extensionHelper] populateNotificationContent:self.bestAttemptContent withContentHandler:contentHandler];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    
    [OneSignal serviceExtensionTimeWillExpireRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent];
    self.contentHandler(self.bestAttemptContent);
}

@end
