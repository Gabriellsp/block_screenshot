import Flutter
import UIKit

public class BlockScreenshotPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.mobile.block_screenshot", binaryMessenger: registrar.messenger())
    let instance = BlockScreenshotPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let window = getKeyWindow() else {
      result(FlutterError(code: "UNAVAILABLE", message: "UIWindow not available", details: nil))
      return
    }

    switch call.method {
    case "disableScreenshot":
      window.makeSecure()
      result(true)
    case "enableScreenshot":
      window.removeSecure()
      result(false)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getKeyWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    } else {
        return UIApplication.shared.keyWindow
    }
  }
}


private var secureTextFieldKey: UInt8 = 0

extension UIWindow {
    private var secureTextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &secureTextFieldKey) as? UITextField
        }
        set {
            objc_setAssociatedObject(self, &secureTextFieldKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func makeSecure() {
        if secureTextField != nil {
            secureTextField?.isSecureTextEntry = true
            return
        }
        let field = UITextField()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))

        let image = UIImageView(image: UIImage(named: "blockScreenshotImage"))
        image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        field.isSecureTextEntry = true

        self.addSubview(field)
        view.addSubview(image)

        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(self.layer)

        field.leftView = view
        field.leftViewMode = .always
        secureTextField = field
    
    }

    func removeSecure() {
        secureTextField?.isSecureTextEntry = false
    }
}
