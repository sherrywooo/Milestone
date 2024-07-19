import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppStyles.TextStyles.buttonTitle)
                .foregroundColor(AppStyles.AppColor.primaryButtonText)
                .padding()
                .frame(maxWidth: .infinity) // Expand button to fill width
                .background(AppStyles.AppColor.primaryButtonBackground)
                .cornerRadius(10)
                .padding(.horizontal) // Add horizontal padding
        }
        .padding(.horizontal) // Additional horizontal padding for the button itself
    }
}


struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppStyles.TextStyles.buttonTitle)
                .foregroundColor(AppStyles.AppColor.secondaryButtonText)
                .padding()
                .background(AppStyles.AppColor.secondaryButtonBackground)
                .cornerRadius(10)
        }
    }
}
