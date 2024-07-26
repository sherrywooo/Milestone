import SwiftUI

struct MilestoneCard: View {
    @Binding var milestone: MilestoneModel
    @ObservedObject var viewModel: MainViewModel
    @State private var showOptions = false
    @State private var navigateToEdit = false
    @State private var showDeleteConfirmation = false // Added state for deletion confirmation
    @State private var itemToDelete: MilestoneModel? // Added state to hold the item to delete

    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(milestone.targetDate, formatter: itemFormatter)")
                        .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText(for: milestone.backgroundColor))
                        .font(AppStyles.TextStyles.dateFont)
                        .padding(.bottom, 5)
                    
                    Text("\(milestone.timeUntil.0)")
                        .foregroundColor(AppStyles.AppColor.milestoneCardSecondaryColor(for: milestone.backgroundColor))
                        .font(AppStyles.TextStyles.durationFont)

                    // Thick divider
                    Rectangle()
                        .fill(AppStyles.AppColor.customDivider(for: milestone.backgroundColor)) // Fill color
                        .frame(width: 40, height: 6) // Height of the divider
                        .padding(.horizontal, 0) // Horizontal padding
                        .padding(.vertical, 6) // Vertical padding

                    Text(milestone.title)
                        .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText(for: milestone.backgroundColor))
                        .font(AppStyles.TextStyles.titleFont)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 20)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                DurationStackView(timeCount: milestone.timeUntil.1, refColor: milestone.backgroundColor)
                    
                Spacer()
            }
            .padding(.top, 80)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(milestone.backgroundColor)
            .padding(.horizontal)
            .padding([.leading, .trailing], -16)
            .onTapGesture {
                withAnimation {
                    showOptions.toggle()
                }
            }

            if showOptions {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddMilestone(viewModel: viewModel)) {
                            Label("", systemImage: "plus")
                                .font(AppStyles.TextStyles.actionicon)
                                .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText(for: milestone.backgroundColor))
                        }

                        Menu {
                            Button(action: {
                                navigateToEdit = true // Set navigateToEdit to true to trigger navigation
                                showOptions.toggle() // Close the options menu after tapping "Edit"
                            }) {
                                Label("Edit", systemImage: "pencil")
                            }

                            Button(action: {
                                itemToDelete = milestone
                                showDeleteConfirmation = true
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .padding()
                                .font(AppStyles.TextStyles.actionicon)
                                .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText(for: milestone.backgroundColor))
                        }
                        .menuStyle(BorderlessButtonMenuStyle())
                    }
                    Spacer()
                }
                .padding()
                .background(Color.clear)
            }
        }
        .background(
            NavigationLink(destination: EditMilestone(milestone: $milestone, viewModel: viewModel), isActive: $navigateToEdit) {
                EmptyView()
            }
            .hidden()
        )
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this milestone?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let item = itemToDelete {
                        viewModel.deleteMilestonebyId(by: item.id)
                    }
                },
                secondaryButton: .cancel {
                    itemToDelete = nil
                }
            )
        }
    }

    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct MilestoneCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel()
        let milestone = MilestoneModel(title: "2025 Stockholm Marathon", targetDate: Date(), backgroundColor: .blue)
        viewModel.items.append(milestone) // Add a sample milestone to viewModel.items
        
        return MilestoneCard(milestone: .constant(milestone), viewModel: viewModel)
            .previewLayout(.fixed(width: 300, height: 200)) // Adjust size as needed
    }
}
