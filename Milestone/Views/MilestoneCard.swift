import SwiftUI

struct MilestoneCard: View {
    @Binding var milestone: MilestoneModel
    @ObservedObject var viewModel: MainViewModel
    @State private var showOptions = false
    @State private var navigateToEdit = false
    // Stylings
        let titleFont = Font.custom("Barlow-SemiBold", size: 32)
        let dateFont = Font.custom("Barlow-Medium", size: 24)
        let durationFont = Font.custom("Barlow-Regular", size: 16)
    
    var body: some View {
        //let refColor = milestone.backgroundColor.brightness(1.6)
       
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(milestone.timeUntil.0)")
                        .foregroundColor(Color.white)
                        .font(durationFont)
                        .padding(.top, 16)
                    
                    Text("\(milestone.targetDate, formatter: itemFormatter)")
                        .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText)
                        .font(dateFont)
                        .padding(.bottom, 5)
                    // Thick divider
                    Rectangle()
                            .fill(Color(hex: "EBC12C")) // Fill color
                            .frame(width: 40, height: 6) // Height of the divider
                            .padding(.horizontal, 0) // Horizontal padding
                            .padding(.vertical, 6) // Vertical padding
                    
                    Text(milestone.title)
                        .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText)
                        .font(titleFont)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top,20)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                
                //Text("\(milestone.timeUntil.1)")
                  //  .foregroundColor(AppStyles.AppColor.milestoneCardPrimaryText)
                  //  .font(durationFont)
                DurationStackView(timeCount: milestone.timeUntil.1)
                Spacer()
                // Display DurationStackView here
            }
            
            .padding()
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
                                .foregroundColor(.white)
                        }
                            
                        Menu {
                            Button(action: {
                                                        navigateToEdit = true // Set navigateToEdit to true to trigger navigation
                                                        showOptions.toggle() // Close the options menu after tapping "Edit"
                                                    }) {
                                                        Label("Edit", systemImage: "pencil")
                                                    }

                            Button(action: {
                                viewModel.deleteMilestonebyId(by: milestone.id)
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .padding()
                                .font(AppStyles.TextStyles.actionicon)
                                .foregroundColor(.white)
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
        let milestone = MilestoneModel(title: "2025 stockholm maration", targetDate: Date(), backgroundColor: .blue)
        viewModel.items.append(milestone) // Add a sample milestone to viewModel.items
        
        return MilestoneCard(milestone: .constant(milestone), viewModel: viewModel)
            .previewLayout(.fixed(width: 300, height: 200)) // Adjust size as needed
    }
}

