import Flutter
import UIKit

public class SwiftBlocRouterGeneratorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bloc_router_generator", binaryMessenger: registrar.messenger())
    let instance = SwiftBlocRouterGeneratorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
