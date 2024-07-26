import SwiftUI

struct CustomPageIndicator: View {
    let currentPage: Int
    let numberOfPages: Int

    private var dotSize: CGFloat {
        numberOfPages > 5 ? 10 : 8 // Larger dots for more than 5 pages
    }

    private var activeDotColor: Color {
        numberOfPages > 5 ? Color.blue : Color.green // Custom colors
    }

    private var inactiveDotColor: Color {
        numberOfPages > 5 ? Color.gray.opacity(0.5) : Color.gray // Custom colors
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                if numberOfPages > 5 && index == currentPage {
                    RoundedRectangle(cornerRadius: dotSize / 2)
                        .fill(activeDotColor)
                        .frame(width: CGFloat(numberOfPages) * dotSize, height: dotSize) // Stretch for more than 5 pages
                } else {
                    Circle()
                        .fill(index == currentPage ? activeDotColor : inactiveDotColor)
                        .frame(width: dotSize, height: dotSize)
                }
            }
        }
    }
}
