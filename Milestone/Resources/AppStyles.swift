import SwiftUI

struct AppStyles {
    struct TextStyles {
        static let pageTitle = Font.custom("Barlow", size: 24)
        static let headline = Font.custom("Barlow", size: 20)
        static let regular = Font.system(size: 16)
        static let actionicon = Font.system(size:24)
        static let buttonTitle = Font.custom("Barlow", size: 18)
        static let countNumber = Font.custom("Barlow", size: 42)
    }

    struct AppColor {
        static let primaryTitle = Color(hex: "0D0E0C")
        static let secondaryTitle = Color(hex: "949494")
        
        static let primaryButtonBackground = Color(hex: "EBC12C")
        static let primaryButtonText = Color(hex: "0D0E0C")
        
        static let secondaryButtonBackground = Color(hex: "0D0E0C")
        static let secondaryButtonText = Color(hex: "FFFFFF")
        
        static let inputFieldBackground = Color(hex: "F3F3F3")
        static let inputFieldSelectedBorder = Color(hex: "0D0E0C")
        
        static let milestoneCardPrimaryText = Color(hex: "FFFFFF")
        
        static let selectedTabItem = Color(hex: "0D0E0C")
        static let unselectedTabItem = Color(hex: "737373")
        
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
