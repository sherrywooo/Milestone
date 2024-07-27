import SwiftUI

struct MilestoneList: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isShowingAddMilestone = false // Controls whether to show the Add Milestone view
    @State private var isShowingEditMilestone = false // Controls whether to show the Edit Milestone view
    @State private var selectedTab: TabSelection = .future

    var filteredMilestones: [MilestoneModel] {
        let currentDate = Date()
        switch selectedTab {
        case .future:
            return viewModel.items.filter { $0.targetDate >= currentDate }
        case .past:
            return viewModel.items.filter { $0.targetDate < currentDate }
        }
    }

    var body: some View {
        VStack {
            Text("Milestones")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            NavigationLink(destination: AddMilestone(viewModel: viewModel), isActive: $isShowingAddMilestone) {
                EmptyView() // Navigation link's destination view is empty; the actual content is replaced by the button
            }
            
            PrimaryButton(title: "Add Milestone") {
                isShowingAddMilestone = true // Set isShowingAddMilestone to true when the button is clicked to trigger the navigation
            }
            .padding(.bottom, 20) // Adjust the button’s position and spacing as needed
            
            Divider()
            
            // Show general empty state if there are no milestones
            if viewModel.items.isEmpty {
                Text("No Milestones Yet")
                    .padding(AppStyles.Padding.large)
                    .font(AppStyles.TextStyles.regular)
                    .foregroundColor(AppStyles.AppColor.secondaryTitle)
                Spacer()
            } else {
                // Show the Picker if there are milestones
                Picker("Select Tab", selection: $selectedTab) {
                    Text("Future")
                        .tag(TabSelection.future)
                    Text("Past")
                        .tag(TabSelection.past)
                }
                .pickerStyle(SegmentedPickerStyle())
                .font(AppStyles.TextStyles.tabLabel)
                .padding()

                // Check if filtered list is empty based on the selected tab
                if filteredMilestones.isEmpty {
                    Text(selectedTab == .future ? "No Future Milestones Yet" : "No Past Milestones Yet")
                        .padding(AppStyles.Padding.large)
                        .font(AppStyles.TextStyles.regular)
                        .foregroundColor(AppStyles.AppColor.secondaryTitle)
                    Spacer()
                } else {
                    // List displaying filtered milestones
                    List {
                        ForEach(filteredMilestones) { milestone in
                            NavigationLink(destination:
                                EditMilestone(milestone: $viewModel.items.first(where: { $0.id == milestone.id })!, viewModel: viewModel)
                            ) {
                                VStack {
                                    HStack {
                                        Rectangle()
                                            .fill(AppStyles.AppColor.bulletColor(for: selectedTab)) // Customize color as needed
                                            .frame(width: 10, height: 10)
                                            .cornerRadius(2)
                                        Text(milestone.title)
                                    }
                                }
                                //.padding(.vertical, 8)
                            }
                         
                            .swipeActions {
                                Button("Delete") {
                                    viewModel.requestDeleteConfirmation(for: milestone)
                                }
                                .tint(.red)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let milestone = filteredMilestones[index]
                                viewModel.requestDeleteConfirmation(for: milestone)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .alert(isPresented: $viewModel.showConfirmationAlert) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this milestone?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let item = viewModel.itemToDelete {
                        // Find the index of the item to delete
                        if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                            viewModel.deleteMilestone(at: index)
                        }
                    }
                },
                secondaryButton: .cancel {
                    viewModel.itemToDelete = nil
                }
            )
        }
    }
}

struct MilestoneList_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneList(viewModel: MainViewModel())
    }
}
