//
//  EditMilestone.swift
//  Milestone
//
//  Created by Sherry Wu on 2024-07-07.
//
import SwiftUI
import Foundation

struct EditMilestone: View {
    //需要 @Binding 和 @ObservedObject，以便绑定现有的 MilestoneModel 实例进行编辑，同时能够调用视图模型中的方法进行更新。
    @Binding var milestone: MilestoneModel
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let formatOptions = ["Years-Months-Days", "Years-Months", "Months-Days", "Days"]
    
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
                ColorPicker("Background Color", selection: $milestone.backgroundColor)
            }
        }
       
        .safeAreaInset(edge: VerticalEdge.bottom) {
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
