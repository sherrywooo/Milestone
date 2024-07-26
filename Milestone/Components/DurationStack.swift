import SwiftUI
import Foundation

struct DurationComponent: Hashable {
    var number: String
    var unit: String
  
}

struct DurationStackView: View {
    let timeCount: String
    var refColor: Color
    
    var body: some View {
        HStack(spacing: 0) {
            let components = parseTimeCount(timeCount: timeCount)
            
            ForEach(components, id: \.self) { component in
                VStack(alignment: .center, spacing: 10) {
                    Text(component.number)
                        .foregroundColor(AppStyles.AppColor.durationStackText(for: refColor))
                        .font(AppStyles.TextStyles.countNumber)
                        .padding(15)
                        .background(AppStyles.AppColor.durationStackBg(for: refColor))
                        .cornerRadius(5)
                        .frame(maxWidth: .infinity)
                    
                    Text(component.unit)
                        .foregroundColor(AppStyles.AppColor.milestoneCardSecondaryColor(for: refColor))
                        .font(AppStyles.TextStyles.countUnit)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .background(Color.clear)
        .frame(maxWidth: .infinity)
    }
    
    private func parseTimeCount(timeCount: String) -> [DurationComponent] {
        let components = timeCount.components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { component -> DurationComponent? in
                let trimmedComponent = component.trimmingCharacters(in: .whitespacesAndNewlines)
                let number = trimmedComponent.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let unit = trimmedComponent.components(separatedBy: CharacterSet.letters.inverted).joined()
                return DurationComponent(number: number, unit: unit )
            }
        return components
    }
}

struct DurationStackView_Previews: PreviewProvider {
    static var previews: some View {
        let timeCount = "20years, 30months, 313days"
        
        return DurationStackView(timeCount: timeCount, refColor:Color.black)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
