import Flutter
import UIKit
import AppTrackingTransparency
import AdSupport

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)

    // Request App Tracking Transparency permission (iOS 14+).
    // Delayed by 1 second so the app UI is fully visible before the dialog appears,
    // which Apple recommends for better user acceptance rates.
    if #available(iOS 14, *) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        ATTrackingManager.requestTrackingAuthorization { status in
          // Firebase Analytics automatically respects this status.
          // No additional action needed here.
        }
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
