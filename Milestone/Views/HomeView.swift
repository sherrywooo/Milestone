import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isShowingAddMilestone = false // 控制是否显示导航链接

    var body: some View {
            VStack {
                if viewModel.items.isEmpty {
                    Text("Home")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                //.padding([.top, .bottom], 20)
                                .padding( .bottom, 20)
             
                   
                    NavigationLink(destination: AddMilestone(viewModel: viewModel), isActive: $isShowingAddMilestone) {
                        EmptyView() // 导航链接的目标视图为空，实际内容由按钮代替
                  
                    }
    
                    PrimaryButton(title: "Add Milestone") {
                            isShowingAddMilestone = true // 点击按钮时，设置isShowingAddMilestone为true，触发导航链接
                    }
                    .padding(.bottom, 20)// 可以根据需要调整按钮的位置和间距
                    
                    Divider()
                    
                    Text("No Milestones Yet")
                        .padding(AppStyles.Padding.large)
                        .font(AppStyles.TextStyles.regular)
                        .foregroundColor(AppStyles.AppColor.secondaryTitle)
                    
                    Spacer()
                    
                   
                    
                } else {
                    TabView {
                        ForEach(viewModel.items.sorted(by: { $0.targetDate < $1.targetDate })) { milestone in
                            if let index = viewModel.items.firstIndex(where: { $0.id == milestone.id }) {
                                MilestoneCard(milestone: $viewModel.items[index], viewModel: viewModel)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    
                }
            }
    }
}
