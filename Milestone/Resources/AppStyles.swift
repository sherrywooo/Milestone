import SwiftUI

struct AppStyles {

    
    struct TextStyles {
        static let pageTitle = Font.custom("Barlow", size: 24)
        static let headline = Font.custom("Barlow", size: 20)
        static let regular = Font.system(size: 16)
        static let actionicon = Font.system(size:24)
        static let buttonTitle = Font.custom("Barlow", size: 18)
        static let formLabel = Font.custom("Barlow-medium", size: 16)
        static let tabLabel = Font.custom("Barlow-medium", size: 24)
       
        
        static let titleFont = Font.custom("Barlow-SemiBold", size: 38)
        static let dateFont = Font.custom("Barlow-Medium", size: 32)
        static let durationFont = Font.custom("Barlow-Regular", size: 20)
        static let countNumber = Font.custom("Barlow", size: 42)
        static let countUnit = Font.custom("Barlow-Regular", size: 20)
        
    }

    struct AppColor {
        static let primaryTitle = Color(hex: "0D0E0C")
        static let secondaryTitle = Color(hex: "949494")
        static let formBg = Color(hex: "F3F3F3")
        static let primaryButtonBackground = Color(hex: "EBC12C")
        static let primaryButtonText = Color(hex: "0D0E0C")
        
        static let secondaryButtonBackground = Color(hex: "0D0E0C")
        static let secondaryButtonText = Color(hex: "FFFFFF")
        
        static let inputFieldBackground = Color(hex: "F3F3F3")
        static let inputFieldSelectedBorder = Color(hex: "0D0E0C")
        
        static let milestoneCardPrimaryText = Color(hex: "FFFFFF")
        
        static let selectedTabItem = Color(hex: "0D0E0C")
        static let unselectedTabItem = Color(hex: "737373")
        static let tabdivider = Color (hex: "DADADA")
        
        static let mWhite = Color(hex:"FFFFFF")
        static let mBlack = Color(hex: "0D0E0C")
        static let mRed = Color(hex: "C33642")
        static let mPink = Color(hex: "DD6670")
        static let mBlue = Color(hex: "4889AF")
        static let mYellow = Color(hex: "EBC12C")
        static let mPurple = Color(hex: "735BF2")
        static let mOrange = Color(hex: "E3832B")
        static let mGreen = Color(hex: "00B383")
        
        // Define the color based on a condition
        static func milestoneCardPrimaryText(for backgroundColor: Color) -> Color {
            // Check if the background color is darkColor or lightColor
            if (backgroundColor == mYellow) {
                return Color.black // White text for dark backgrounds
            } 
            if (backgroundColor == mWhite){
                return Color.black // White text for dark backgrounds
            } else {
                return Color.white // Black text for light backgrounds
            }
        }
        
        static func milestoneCardSecondaryColor(for backgroundColor: Color) -> Color {
               // Switch case to return different colors based on the background color
               switch backgroundColor {
               case mBlack:
                   return Color(hex: "AFAFAF") // Light gray
               case mRed:
                   return Color(hex: "FFD4D7") // Light pink
               case mPink:
                   return Color(hex: "7A2F35") // Dark red
               case mBlue:
                   return Color(hex: "8FC6E6") // Light blue
               case mYellow:
                   return Color(hex: "735E14") // Dark yellow
               case mPurple:
                   return Color(hex: "C3BAF3") // Light purple
               case mOrange:
                   return Color(hex: "995414") // Dark orange
               case mGreen:
                   return Color(hex: "005840") // Dark green
               default:
                   return Color.gray // Default color
               }
           }
        
        static func customDivider(for backgroundColor: Color) -> Color {
            // Check if the background color is darkColor or lightColor
            if (backgroundColor == mYellow) {
                return Color.black // White text for dark backgrounds
            } else {
                return mYellow // Black text for light backgrounds
            }
        }
        static func durationStackBg(for backgroundColor: Color) -> Color {
            // Check if the background color is darkColor or lightColor
            if (backgroundColor == mBlack) {
                return Color.white // White text for dark backgrounds
            } else {
                return Color.black // Black text for light backgrounds
            }
        }
        static func durationStackText (for backgroundColor: Color) -> Color {
            // Check if the background color is darkColor or lightColor
            if (backgroundColor == mBlack) {
                return Color.black // White text for dark backgrounds
            } else {
                return Color.white// Black text for light backgrounds
            }
        }
  
        static func bulletColor(for tabSelection: TabSelection) -> Color {
                   switch tabSelection {
                   case .future:
                       return mYellow
                   case .past:
                       return mBlack
                   }
               }
        
        // Retaining the existing color definitions for compatibility
        static let primary = primaryButtonBackground
        static let secondary = secondaryTitle
        static let text = primaryTitle
        static let background = inputFieldBackground
        static let buttonBackground = primaryButtonBackground
    }

    struct Padding {
        static let large = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        static let medium = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        static let small = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    }

    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(TextStyles.buttonTitle)
                .foregroundColor(AppColor.primaryButtonText)
                .padding()
                .background(AppColor.primaryButtonBackground)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .frame(maxWidth: .infinity) // Expand button to fill width
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
