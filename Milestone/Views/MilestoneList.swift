import SwiftUI

struct MilestoneList: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isShowingAddMilestone = false // Controls whether to show the Add Milestone view
    @State private var isShowingEditMilestone = false // Controls whether to show the Edit Milestone view
    
    var body: some View {
        VStack {
            Text("Milestones")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 30)
            
            NavigationLink(destination: AddMilestone(viewModel: viewModel), isActive: $isShowingAddMilestone) {
                EmptyView() // Navigation link's destination view is empty; the actual content is replaced by the button
            }
            
            PrimaryButton(title: "Add Milestone") {
                isShowingAddMilestone = true // Set isShowingAddMilestone to true when the button is clicked to trigger the navigation
            }
            .padding(.bottom, 20) // Adjust the button’s position and spacing as needed
            
            Divider()
            
            if viewModel.items.isEmpty {
                Text("No Milestones Yet")
                    .padding(AppStyles.Padding.large)
                    .font(AppStyles.TextStyles.regular)
                    .foregroundColor(AppStyles.AppColor.secondaryTitle)
            }
            
            List {
                ForEach(viewModel.items) { milestone in
                    NavigationLink(destination:
                        EditMilestone(milestone: $viewModel.items.first(where: { $0.id == milestone.id })!, viewModel: viewModel)
                    ) {
                        Text(milestone.title)
                    }
                    .swipeActions {
                        Button("Delete") {
                            if let index = viewModel.items.firstIndex(where: { $0.id == milestone.id }) {
                                viewModel.deleteMilestone(at: index)
                            }
                        }
                        .tint(.red)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteMilestone(at: index)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct MilestoneList_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneList(viewModel: MainViewModel())
    }
}
