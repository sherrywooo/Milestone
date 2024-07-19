import SwiftUI

struct MilestoneList: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isShowingAddMilestone = false // 控制是否显示导航链接
    @State private var isShowingEditMilestone = false // 控制是否显示导航链接
    
    var body: some View {
            VStack {
                Text("Milestones")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            //.padding([.top, .bottom], 20)
                            .padding( .bottom, 30)
         
               
                NavigationLink(destination: AddMilestone(viewModel: viewModel), isActive: $isShowingAddMilestone) {
                    EmptyView() // 导航链接的目标视图为空，实际内容由按钮代替
                }

                PrimaryButton(title: "Add Milestone") {
                        isShowingAddMilestone = true // 点击按钮时，设置isShowingAddMilestone为true，触发导航链接
                }
                .padding(.bottom, 20) // 可以根据需要调整按钮的位置和间距
                
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
                                            //EditMilestone(milestone: $viewModel.items.first(where: { $0.id == milestone.id })!, viewModel: viewModel)
                                           MilestoneCard(milestone: $viewModel.items.first(where: { $0.id == milestone.id })!, viewModel: viewModel)) {
                                Text(milestone.title)
                            }
                            .swipeActions {
                                Button("Delete") {
                                    if let index = viewModel.items.firstIndex(where: { $0.id == milestone.id }) {
                                        viewModel.deleteMilestone(at: index)
                                    }
                                }
                                .tint(.red)
                                
                                //NavigationLink(destination: EditMilestone( milestone: $viewModel.items.first(where: { $0.id == milestone.id })!, viewModel: viewModel, isActive: $isShowingEditMilestone)) {
                                  //  EmptyView() // 导航链接的目标视图为空，实际内容由按钮代替
                             //   }

                                Button("Edit") {
                                    isShowingEditMilestone = true
                                }
                                .tint(.blue)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            for index in indexSet {
                                viewModel.deleteMilestone(at: index)
                                }
                            })
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
