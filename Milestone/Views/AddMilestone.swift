import SwiftUI

struct AddMilestone: View {
        //只需要 @ObservedObject，因为不需要绑定现有的 MilestoneModel 实例。
        @ObservedObject var viewModel: MainViewModel
        @Environment(\.presentationMode) var presentationMode
        //确保在用户保存数据后，能够返回到之前的页面：
        @State private var title: String = ""
        @State private var targetDate: Date = Date()
        @State private var backgroundColor: Color = .blue
        @State private var selectedFormat: String = ""
        //@State 属性包装器用于管理视图内部的状态，是私有的，不能直接传递给外部。但是，可以在用户点击保存按钮时，将 @State 管理的变量的值传递给视图模型的方法，从而将数据传递出去。
        
        let formatOptions = ["Years-Months-Days", "Years-Months", "Months-Days", "Days"]

        var body: some View {
            NavigationView {
                VStack {
                        Form {
                            Section(header: Text("Title")) {
                                    TextField("Milestone title", text: $title)
                            }

                            Section(header: Text("Target Date")) {
                                DatePicker("Select", selection: $targetDate, displayedComponents: .date)
                                
                            }
                            
                            Section(header: Text("Display Format")) {
                                Picker("Select", selection: $selectedFormat) {
                                    ForEach(formatOptions, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity, alignment: .leading)
                               // .labelsHidden()
                                .clipped()
                            }
                            
                            Section(header: Text("Background Color")) {
                                ColorPicker("Background Color", selection: $backgroundColor)
                            }
                        }

                    }
                    .background(Color.black)
                    .safeAreaInset(edge: VerticalEdge.bottom) {
                        PrimaryButton(title: "Save") {
                            viewModel.addMilestone(title: title, targetDate: targetDate, displayFormat: selectedFormat, backgroundColor: backgroundColor)
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
