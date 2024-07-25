import SwiftUI
import Foundation

struct EditMilestone: View {
    @Binding var milestone: MilestoneModel
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let formatOptions = ["Years-Months-Days", "Years-Months", "Months-Days", "Days"]
    
    // Convert Color to ColorOption
    private var selectedColorOption: ColorOption? {
        colorOptions.first { $0.color == milestone.backgroundColor }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $milestone.title)
            }
            
            Section(header: Text("Target Date")) {
                DatePicker("Target Date", selection: $milestone.targetDate, displayedComponents: .date)
            }
            
            Section(header: Text("Display Format")) {
                Picker("Display Format", selection: $milestone.displayFormat) {
                    ForEach(formatOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity, alignment: .leading) // Adjust width to match other sections
                .labelsHidden()
                .clipped()
            }
            
            Section(header: Text("Background Color")) {
                Picker("Select Color", selection: Binding(
                    get: { selectedColorOption ?? colorOptions.first! },
                    set: { newColorOption in
                        if let newColor = newColorOption?.color {
                            milestone.backgroundColor = newColor
                        }
                    }
                )) {
                    ForEach(colorOptions) { option in
                        HStack {
                            Rectangle()
                                .fill(option.color)
                                .frame(width: 30, height: 30)
                                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                            Text(option.name)
                        }
                        .tag(option as ColorOption?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
       
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Save") {
                viewModel.updateMilestone(with: milestone)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(alignment: .bottom)
        }
            
        .navigationBarTitle("Edit Milestone", displayMode: .inline)
    }
}

struct EditMilestone_Previews: PreviewProvider {
    static var previews: some View {
        EditMilestone(
            milestone: .constant(
                MilestoneModel(
                    title: "Sample Milestone",
                    targetDate: Date(),
                    displayFormat: "Years-Months-Days",
                    backgroundColor: .blue
                )
            ),
            viewModel: MainViewModel()
        )
    }
}
