import SwiftUI

struct AddMilestone: View {
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var targetDate: Date = Date()
    @State private var backgroundColor: Color = .blue
    @State private var selectedFormat: String = ""
    let formatOptions = ["Years-Months-Days", "Years-Months", "Months-Days", "Days"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Title")) {
                        TextField("Enter Title", text: $title)
                    }
                    
                    Section(header: Text("Target Date")) {
                        DatePicker("Target Date", selection: $targetDate, displayedComponents: .date)
                    }
                    
                    Section(header: Text("Display Format")) {
                        Picker("Display Format", selection: $selectedFormat) {
                            ForEach(formatOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading) // Adjust width to match other sections
                        .labelsHidden()
                        .clipped()
                    }
                    
                    Section(header: Text("Background Color")) {
                        ColorPicker("Background Color", selection: $backgroundColor)
                    }
                }
                
                Spacer()
                
                PrimaryButton(title: "Save") {
                    viewModel.addMilestone(title: title, targetDate: targetDate, displayFormat: selectedFormat, backgroundColor: backgroundColor)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                .navigationBarTitle("Add Milestone", displayMode: .inline)
            }
        }
    }
}
