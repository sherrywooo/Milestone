import SwiftUI
/*MVVM Architecture
 Model: Data point
 View: UI
 ViewModel: Manage Models for View
 */
@main
struct MilestoneApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
            //Wrap the list in the navigation view (native)
            ContentView() // The first screen of the app
            }
        }
    }
}
