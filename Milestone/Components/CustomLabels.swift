import SwiftUI

struct CustomPickerLabel: View {
    @Binding var selectedValue: String
    let placeholder: String
    let placeholderColor: Color
    let selectedColor: Color
    
    var body: some View {
        Text(selectedValue.isEmpty ? placeholder : selectedValue)
            .foregroundColor(selectedValue.isEmpty ? placeholderColor : selectedColor)
    }
}

struct CustomPickerLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomPickerLabel(
            selectedValue: .constant(""),
            placeholder: "Select",
            placeholderColor: .gray,
            selectedColor: .black
        )
    }
}
