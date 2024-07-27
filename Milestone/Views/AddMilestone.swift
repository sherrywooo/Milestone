import SwiftUI

// Define ColorOption
struct ColorOption: Identifiable, Hashable {
    let id = UUID()
    let color: Color
    let name: String
}

// Sample color options
let colorOptions: [ColorOption] = [
    ColorOption(color:AppStyles.AppColor.mWhite,name:"White"),
    ColorOption(color: AppStyles.AppColor.mBlack, name: "Black"),
    ColorOption(color: AppStyles.AppColor.mYellow, name: "Yellow"),
    ColorOption(color: AppStyles.AppColor.mRed, name: "Red"),
    ColorOption(color: AppStyles.AppColor.mPink, name: "Pink"),
    ColorOption(color: AppStyles.AppColor.mOrange, name: "Orange"),
    ColorOption(color: AppStyles.AppColor.mGreen, name: "Green"),
    ColorOption(color: AppStyles.AppColor.mBlue, name: "Blue"),
    ColorOption(color: AppStyles.AppColor.mPurple, name: "Purple")
]

struct AddMilestone: View {
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var targetDate: Date = Date()
    @State private var selectedColorOption: ColorOption = colorOptions.first!
    @State private var selectedFormat: String = "Years-Months-Days"
    
    let formatOptions = ["Years-Months-Days", "Years-Months", "Months-Days", "Days"]

    var body: some View {
            VStack {
                Form {
                    Section(header: Text("Title")
                        .font(AppStyles.TextStyles.formLabel)
                        .frame(width: 100, alignment: .leading)
                    ){
                        TextField("Milestone title", text: $title)
                        .onChange(of: title) { newValue in
                                                    // Limit the text length to 30 characters
                                                    if newValue.count > 30 {
                                                        title = String(newValue.prefix(72))
                                                    }
                                                }
                    }
                    
                    Section(header: Text("Target Date")
                        .font(AppStyles.TextStyles.formLabel)) {
                        DatePicker("Select", selection: $targetDate, displayedComponents: .date)
                    }
                    
                    Section(header: Text("Display Format")
                        .font(AppStyles.TextStyles.formLabel)) {
                        Picker("Select", selection: $selectedFormat) {
                            ForEach(formatOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Section(header: Text("Background Color")
                        .font(AppStyles.TextStyles.formLabel)) {
                        Picker("Select Color", selection: $selectedColorOption) {
                            ForEach(colorOptions) { option in
                                HStack {
                                    Rectangle()
                                        .fill(option.color)
                                        .frame(width: 30, height: 30)
                                        .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                                    Text(option.name)
                                }
                                .tag(option) // Picker uses ColorOption directly
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .background(Color.black)
                
                .safeAreaInset(edge: .bottom) {
                    PrimaryButton(title: "Save") {
                        viewModel.addMilestone(title: title, targetDate: targetDate, displayFormat: selectedFormat, backgroundColor: selectedColorOption.color)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(alignment: .bottom)
                }
            }
            .navigationBarTitle("Add Milestone", displayMode: .inline)
    }
}

struct AddMilestone_Previews: PreviewProvider {
    static var previews: some View {
        AddMilestone(viewModel: MainViewModel()) // Replace with your actual MainViewModel instance
    }
}
