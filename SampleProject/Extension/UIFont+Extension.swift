//
//  UIFont+Extension.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit

extension UIFont {
    class func printFontFamily(){
        for family in UIFont.familyNames {
            print("Family \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("Members----\(name)")
            }
        }
    }

    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
            let descriptor = self.fontDescriptor
                .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
            return UIFont(descriptor: descriptor!, size: 0)
        }

        func bold() -> UIFont {
            return withTraits(traits: .traitBold)
        }
    }


public func getAppropriateFontName(fromType: FontType) -> String{
    let language = AppLanguage.english
     switch language {
     case .english:
        switch fromType {
       
        case .GoldplayThin:
            return FontName.GoldplayThin
        case .GoldplayRegular:
            return FontName.GoldplayRegular
        case .GoldplayMedium:
            return FontName.GoldplayMedium
        case .GoldplaySemiBold:
            return FontName.GoldplaySemiBold
        case .GoldplayBold:
            return FontName.GoldplayBold
        case .GoldplayBlack:
            return FontName.GoldplayBlack
        case .LatinotypeGoloplayLight:
            return FontName.LatinotypeGoloplayLight
//        case .segoeUISemibold:
//            return FontName.segoeUISemibold
//        case .segoeUISemiItalic:
//            return FontName.segoeUISemiItalic
//        case .segoeUISemilight:
//            return FontName.segoeUISemilight
//        case .segoeUISemilightItalic:
//            return FontName.segoeUISemilightItalic
//        case .segoeUIBold:
//            return FontName.segoeUIBold
        }
     }
 }
public final class StaticFont{
    class func font(type: FontType, size: FontSize) -> UIFont {
        return UIFont(name: getAppropriateFontName(fromType: type), size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }

}

public final class DynamicFont{
    class func font(type: FontType, size: FontSize, textStyle: UIFont.TextStyle? = nil) -> UIFont {
        guard let font = UIFont(name: getAppropriateFontName(fromType: type), size: size.rawValue) else {return UIFont.preferredFont(forTextStyle: getStyle(size: size, textStyle: textStyle))}
        let fontMetrics = UIFontMetrics(forTextStyle: getStyle(size: size, textStyle: textStyle))
        return fontMetrics.scaledFont(for: font)
    }
    
    class func getStyle(size: FontSize, textStyle: UIFont.TextStyle?) -> UIFont.TextStyle{
        if let style = textStyle{
            return style
        }
        switch size {
      
        case .size11, .size10:
            return .caption2
        case .size12:
            return .caption1
        case .size13:
            return .footnote
        case .size14:
            return .subheadline
        case .size15:
            return .subheadline
        case .size16:
            return .callout
        case .size17:
            return .body
        case .size18:
            return .body
        case .size20:
            return .title3
        case .size22:
            return .title2
        case .size24:
            return .title1
        case .size25:
            return .title1
        case .size28:
            return .title1
        case .size30:
            return .largeTitle
      
        case .size32:
            return .largeTitle
        }
    }
 
}
//Members----Helvetica
//Members----Helvetica-Oblique

//Members----Helvetica-Compressed
//Members----HelveticaRounded-Bold
//Members----Helvetica-BoldOblique
//Members----Helvetica-Bold
//Members----Helvetica-Light
//Members----Helvetica-LightOblique

public enum FontType: String{
//    case segoeUI = "Segoe UI 400"
//    case segoeUIBlack = "Segoe UI Black 900"
//    case segoeUIBlackItalic = "Segoe UI Black Italic 900"
//    case segoeUIGras = "Segoe UI Gras 700"
//    case segoeUIItalique = "Segoe UI Italique 400"
//    case segoeUILight = "Segoe UI Light 300"
//    case segoeUILightItalic = "Segoe UI Light Italic 300"
//    case segoeUISemibold = "SegoeUI-Semibold"
//    case  segoeUISemiItalic = "Segoe UI Semibold Italic 600"
//    case segoeUISemilight = "Segoe UI Semilight 350"
//    case segoeUISemilightItalic = "Segoe UI Semilight Italic 350"
//    case  segoeUIBold = "Segoe UI Bold"
    
    case GoldplayBlack = "Goldplay-Black"
    case GoldplayBold = "Goldplay-Bold"
    case GoldplayRegular = "Goldplay-Regular"
    case GoldplaySemiBold = "Goldplay-SemiBold"
    case GoldplayThin = "Goldplay-Thin"
    case LatinotypeGoloplayLight = "Latinotype-Goloplay-Light"
    case GoldplayMedium = "Goldplay-Medium"
    
}
struct FontName {
    static let GoldplayBlack = "Goldplay-Black"
    static let GoldplaySemiBold = "Goldplay-SemiBold"
    static let GoldplayBold = "Goldplay-Bold"
    static let GoldplayRegular = "Goldplay-Regular"
    static let GoldplayThin = "Goldplay-Thin"
    static let LatinotypeGoloplayLight = "Latinotype-Goloplay-Light"
    static let GoldplayMedium = "Goldplay-Medium"
//    static let segoeUILightItalic = "SegoeUI-LightItalic"
//    static let segoeUISemibold = "SegoeUI-Semibold"
//    static let segoeUISemiItalic = "Segoe UI Semibold Italic 600"
//    static let segoeUISemilight = "SegoeUI-Semilight"
//    static let segoeUISemilightItalic = "SegoeUI-SemilightItalic"
//    static let segoeUIBold = "SegoeUI-Bold"
}
enum FontSize: CGFloat{
    case size10 = 10 //caption2
    case size11 = 11 //caption2
    case size12 = 12 //caption1
    case size13 = 13 //footnote
    case size14 = 14 //subheadline
    case size15 = 15 //subheadline
    case size16 = 16 //callout
    case size17 = 17 //headline, body
    case size18 = 18 //headline, body
    case size20 = 20 //title3
    case size22 = 22 //title2
    case size24 = 24 //title1
    case size25 = 25 //title1
    case size28 = 28 //title1
    case size30 = 30 //largeTitle
    case size32 = 32

}
public enum AppLanguage: String {
    case english = "en"
   
}

