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
typealias Images = Assets.Images
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
  internal enum Images {
    internal static let iconAccount = ImageAsset(name: "iconAccount")
    internal static let iconAppLaunch = ImageAsset(name: "iconAppLaunch")
    internal static let iconArrowBack = ImageAsset(name: "iconArrowBack")
    internal static let iconArrowDropDown = ImageAsset(name: "iconArrowDropDown")
    internal static let iconArrowForward = ImageAsset(name: "iconArrowForward")
    internal static let iconBackgroundCar = ImageAsset(name: "iconBackgroundCar")
    internal static let iconBookmark = ImageAsset(name: "iconBookmark")
    internal static let iconCash = ImageAsset(name: "iconCash")
    internal static let iconCheckBox = ImageAsset(name: "iconCheckBox")
    internal static let iconCoupon = ImageAsset(name: "iconCoupon")
    internal static let iconCreditCard = ImageAsset(name: "iconCreditCard")
    internal static let iconCustomerService = ImageAsset(name: "iconCustomerService")
    internal static let iconDestinationLocationMarker = ImageAsset(name: "iconDestinationLocationMarker")
    internal static let iconDevice = ImageAsset(name: "iconDevice")
    internal static let iconDoubleBookmark = ImageAsset(name: "iconDoubleBookmark")
    internal static let iconEmptyCheckBox = ImageAsset(name: "iconEmptyCheckBox")
    internal static let iconEmptyProfile = ImageAsset(name: "iconEmptyProfile")
    internal static let iconForward = ImageAsset(name: "iconForward")
    internal static let iconGps = ImageAsset(name: "iconGps")
    internal static let iconGrayCar = ImageAsset(name: "iconGrayCar")
    internal static let iconHamburger = ImageAsset(name: "iconHamburger")
    internal static let iconHistory = ImageAsset(name: "iconHistory")
    internal static let iconHome = ImageAsset(name: "iconHome")
    internal static let iconInfo = ImageAsset(name: "iconInfo")
    internal static let iconLocation = ImageAsset(name: "iconLocation")
    internal static let iconLogo = ImageAsset(name: "iconLogo")
    internal static let iconMagnifyingGlass = ImageAsset(name: "iconMagnifyingGlass")
    internal static let iconMapPin = ImageAsset(name: "iconMapPin")
    internal static let iconNavigation = ImageAsset(name: "iconNavigation")
    internal static let iconNotificationActive = ImageAsset(name: "iconNotificationActive")
    internal static let iconPayment = ImageAsset(name: "iconPayment")
    internal static let iconPencil = ImageAsset(name: "iconPencil")
    internal static let iconPhone = ImageAsset(name: "iconPhone")
    internal static let iconPin = ImageAsset(name: "iconPin")
    internal static let iconPinShadow = ImageAsset(name: "iconPinShadow")
    internal static let iconPlus = ImageAsset(name: "iconPlus")
    internal static let iconPromotion = ImageAsset(name: "iconPromotion")
    internal static let iconRatingStar = ImageAsset(name: "iconRatingStar")
    internal static let iconReport = ImageAsset(name: "iconReport")
    internal static let iconRouteLine = ImageAsset(name: "iconRouteLine")
    internal static let iconRunningPerson = ImageAsset(name: "iconRunningPerson")
    internal static let iconSettings = ImageAsset(name: "iconSettings")
    internal static let iconShare = ImageAsset(name: "iconShare")
    internal static let iconSilverCar = ImageAsset(name: "iconSilverCar")
    internal static let iconSourceLocationMarker = ImageAsset(name: "iconSourceLocationMarker")
    internal static let iconStar = ImageAsset(name: "iconStar")
    internal static let iconSupport = ImageAsset(name: "iconSupport")
    internal static let iconTranslate = ImageAsset(name: "iconTranslate")
    internal static let iconTrash = ImageAsset(name: "iconTrash")
    internal static let iconUpdateApp = ImageAsset(name: "iconUpdateApp")
    internal static let iconUserLocation = ImageAsset(name: "iconUserLocation")
    internal static let iconUserLocationMarker = ImageAsset(name: "iconUserLocationMarker")
    internal static let iconUserLocationPuck = ImageAsset(name: "iconUserLocationPuck")
    internal static let iconUserLocationPuckArrow = ImageAsset(name: "iconUserLocationPuckArrow")
    internal static let iconWork = ImageAsset(name: "iconWork")
    internal static let iconXMark = ImageAsset(name: "iconXMark")
    internal static let iconYellowCar = ImageAsset(name: "iconYellowCar")
    internal static let iconTaxiBusiness = ImageAsset(name: "iconTaxiBusiness")
    internal static let iconTaxiStandart = ImageAsset(name: "iconTaxiStandart")
    internal static let iconTaxiStart = ImageAsset(name: "iconTaxiStart")
    internal static let toastActive = ImageAsset(name: "toastActive")
    internal static let toastError = ImageAsset(name: "toastError")
    internal static let toastSuccess = ImageAsset(name: "toastSuccess")
    internal static let temp1 = ImageAsset(name: "temp1")
    internal static let tempAndroid = ImageAsset(name: "tempAndroid")
    internal static let tempDriverAvatar = ImageAsset(name: "tempDriverAvatar")
    internal static let tempFullPromotion = ImageAsset(name: "tempFullPromotion")
    internal static let tempHalfPromotion1 = ImageAsset(name: "tempHalfPromotion1")
    internal static let tempHalfPromotion2 = ImageAsset(name: "tempHalfPromotion2")
    internal static let tempIconPin = ImageAsset(name: "tempIconPin")
    internal static let tempPromotion1 = ImageAsset(name: "tempPromotion1")
    internal static let tempPromotion2 = ImageAsset(name: "tempPromotion2")
    internal static let tempPromotion3 = ImageAsset(name: "tempPromotion3")
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
