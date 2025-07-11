import Flutter
import GoogleMaps
import UIKit
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      // Registry in this case is the FlutterEngine that is created in Workmanager's
      // performFetchWithCompletionHandler or BGAppRefreshTask.
      // This will make other plugins available during a background operation.
      GeneratedPluginRegistrant.register(with: registry)
    }
    // In AppDelegate.application method
    WorkmanagerPlugin.registerBGProcessingTask(
      withIdentifier: "com.alandelgado.miscelaneos.fetch-background-pokemon")

    // Register a periodic task in iOS 13+
    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: "com.alandelgado.miscelaneos.fetch-periodic-background-pokemon",
      frequency: NSNumber(value: 20 * 60))

    GMSServices.provideAPIKey("AIzaSyDfk7CUbBeOVe73UajnnkxlybP_ooeYTP8")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
