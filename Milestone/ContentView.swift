import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedTab = 0

    let tabItems = [
        (title: "Home", icon: "house"),
        (title: "Milestones", icon: "list.bullet")
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Main content view
                Group {
                    if selectedTab == 0 {
                        HomeView(viewModel: viewModel)
                    } else {
                        MilestoneList(viewModel: viewModel)
                    }
                }
                .background(Color.white) // Ensure content background matches tab bar
                
                // Custom tab bar
                CustomTabBar(selectedTab: $selectedTab, items: tabItems)
                    .frame(height: 60) // Adjust height as needed
                    .padding(.bottom, 20)
            }
            .navigationBarHidden(true) // Hide navigation bar if not needed
            .edgesIgnoringSafeArea(.bottom) // Ensure content fills the safe area to avoid gaps
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
