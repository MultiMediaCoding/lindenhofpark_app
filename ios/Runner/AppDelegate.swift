import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "LindenhofGlass") {
      registrar.register(GlassViewFactory(), withId: "lindenhof/glass")
    }
  }
}

/// Echtes Liquid Glass (iOS 26+) beziehungsweise ein Material-Blur als Hintergrund
/// für Flutter-Inhalte. Flutter kann den WebView der Karte nicht selbst
/// weichzeichnen, deshalb liefert diese native Ansicht den Glaseffekt.
final class GlassViewFactory: NSObject, FlutterPlatformViewFactory {
  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }

  func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
    let params = args as? [String: Any]
    let radius = (params?["radius"] as? NSNumber)?.doubleValue ?? 32
    let dark = (params?["dark"] as? Bool) ?? false
    return GlassPlatformView(radius: CGFloat(radius), dark: dark)
  }
}

final class GlassPlatformView: NSObject, FlutterPlatformView {
  private let effectView = UIVisualEffectView()

  init(radius: CGFloat, dark: Bool) {
    super.init()
    effectView.overrideUserInterfaceStyle = dark ? .dark : .light
    if #available(iOS 26.0, *) {
      effectView.effect = UIGlassEffect()
      effectView.cornerConfiguration = .corners(radius: .fixed(radius))
    } else {
      effectView.effect = UIBlurEffect(style: .systemThinMaterial)
      effectView.layer.cornerRadius = radius
      effectView.clipsToBounds = true
    }
  }

  func view() -> UIView { effectView }
}
