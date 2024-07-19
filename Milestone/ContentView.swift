import SwiftUI

struct ContentView: View {
    //@StateObject：用于在父视图中创建视图模型实例，并在其生命周期内保持该实例。
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView(viewModel: viewModel)
                    .tabItem {
                        Label("Home", systemImage: "house")
                            
                    }
                    .tag(0)
                MilestoneList(viewModel: viewModel)
                    .tabItem {
                        Label("Milestones", systemImage: "list.bullet")
                    }
                    .tag(1)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


