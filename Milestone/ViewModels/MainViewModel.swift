// CRUD functions 处理数据逻辑
import Foundation
import SwiftUI

//定义一个类，它遵循Observerable object协议
class MainViewModel: ObservableObject {
    // 使用Published属性包装起，将items数组声明成可观察的
    @Published var items : [MilestoneModel] = []
    //初始化方法，在对象创建时调用
    init (){
        getItems()
        //调用getItems方法获取初始数据
    }
    
    //获取初始数据
    func getItems() {
        //创建一个新的MilestoneModel数组，包含两个初始实例
        
        let newItems: [MilestoneModel] = []
        items.append(contentsOf: newItems)

    }
    
    //添加新Milestone
    func addMilestone(
        title:String,
        targetDate:Date,
        displayFormat:String = "",
        backgroundColor: Color)
    {
        //创建一个新的MilestoneModel实例
        let newMilestone = MilestoneModel(
            title:title,
            targetDate: targetDate,
            displayFormat:displayFormat,
            backgroundColor: backgroundColor
        )
        //将新创建的里程碑添加到items数组中
        items.append(newMilestone)
        
    }
    
    //删除和更新都可以通过index或id来写，但通过 id 来进行更新和删除操作是一种更常见和标准的方法，尤其是在需要频繁对数组进行操作的情况下。
    
    //删除里程碑
    func deleteMilestone(at index:Int){
        //检查索引是否在items数组的范围内
        guard items.indices.contains(index) else{return}
        //从items数组中删除指定索引处的里程碑
        items.remove(at: index)
    }
    
    func deleteMilestonebyId(by id: UUID) {
           items.removeAll { $0.id == id }
       }
    
    //更新里程碑
    func updateMilestone(with newMilestone: MilestoneModel) {
            if let index = items.firstIndex(where: { $0.id == newMilestone.id }) {
                items[index] = newMilestone
            }
        }

}
