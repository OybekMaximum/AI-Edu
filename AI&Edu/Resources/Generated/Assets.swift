// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
typealias Colors = Assets.Colors
internal enum Assets {
  internal enum Colors {
    internal static let backgroundAccent = ColorAsset(name: "backgroundAccent")
    internal static let backgroundAccentLight = ColorAsset(name: "backgroundAccentLight")
    internal static let backgroundBrand = ColorAsset(name: "backgroundBrand")
    internal static let backgroundInverseDisabled = ColorAsset(name: "backgroundInverseDisabled")
    internal static let backgroundInversePrimary = ColorAsset(name: "backgroundInversePrimary")
    internal static let backgroundInverseSecondary = ColorAsset(name: "backgroundInverseSecondary")
    internal static let backgroundNegative = ColorAsset(name: "backgroundNegative")
    internal static let backgroundNegativeLight = ColorAsset(name: "backgroundNegativeLight")
    internal static let backgroundOverlay = ColorAsset(name: "backgroundOverlay")
    internal static let backgroundPositive = ColorAsset(name: "backgroundPositive")
    internal static let backgroundPositiveLight = ColorAsset(name: "backgroundPositiveLight")
    internal static let backgroundPrimary = ColorAsset(name: "backgroundPrimary")
    internal static let backgroundQuaternary = ColorAsset(name: "backgroundQuaternary")
    internal static let backgroundSecondary = ColorAsset(name: "backgroundSecondary")
    internal static let backgroundTertiary = ColorAsset(name: "backgroundTertiary")
    internal static let backgroundWarning = ColorAsset(name: "backgroundWarning")
    internal static let backgroundWarningLight = ColorAsset(name: "backgroundWarningLight")
    internal static let borderAccent = ColorAsset(name: "borderAccent")
    internal static let borderBlack = ColorAsset(name: "borderBlack")
    internal static let borderNegative = ColorAsset(name: "borderNegative")
    internal static let borderPositive = ColorAsset(name: "borderPositive")
    internal static let borderPrimary = ColorAsset(name: "borderPrimary")
    internal static let borderWarning = ColorAsset(name: "borderWarning")
    internal static let borderWhite = ColorAsset(name: "borderWhite")
    internal static let commonBlack = ColorAsset(name: "commonBlack")
    internal static let commonWhite = ColorAsset(name: "commonWhite")
    internal static let contentAccent = ColorAsset(name: "contentAccent")
    internal static let contentBrand = ColorAsset(name: "contentBrand")
    internal static let contentInverseDisabled = ColorAsset(name: "contentInverseDisabled")
    internal static let contentInversePrimary = ColorAsset(name: "contentInversePrimary")
    internal static let contentInverseSecondary = ColorAsset(name: "contentInverseSecondary")
    internal static let contentNegative = ColorAsset(name: "contentNegative")
    internal static let contentPositive = ColorAsset(name: "contentPositive")
    internal static let contentPrimary = ColorAsset(name: "contentPrimary")
    internal static let contentSecondary = ColorAsset(name: "contentSecondary")
    internal static let contentTertiary = ColorAsset(name: "contentTertiary")
    internal static let contentWarning = ColorAsset(name: "contentWarning")
    internal static let gradientBottom = ColorAsset(name: "gradientBottom")
    internal static let gradientTop = ColorAsset(name: "gradientTop")
    internal static let iconSecondary = ColorAsset(name: "iconSecondary")
    internal static let shadowAccent = ColorAsset(name: "shadowAccent")
    internal static let shadowNegative = ColorAsset(name: "shadowNegative")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

extension UIColor {
    /// Initializes a new UIColor instance from a hex string and alpha
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
