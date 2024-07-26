import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let items: [(title: String, icon: String)]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(0..<items.count, id: \.self) { index in
                    Button(action: {
                        selectedTab = index
                    }) {
                        VStack {
                            Image(systemName: items[index].icon)
                            Text(items[index].title)
                        }
                        .padding()
                        .foregroundColor(selectedTab == index ? AppStyles.AppColor.mBlack : Color.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(Color.white) // Background color of the tab bar
            .overlay(
                Rectangle()
                    .fill(AppStyles.AppColor.tabdivider) // Divider color
                    .frame(height: 1), // Height of the divider
                alignment: .top
            )
        }
        .background(Color.white) // Ensures background color consistency
        .frame(maxWidth: .infinity) // Ensure tab bar takes full width
    }
}
