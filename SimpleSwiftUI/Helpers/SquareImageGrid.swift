import SwiftUI

struct SquareImagesGrid: View {
    let imageNames: [String]
    var spacing: Double = 2
    var columnCount: Int = 3
    var cornerRadius: Double = 8.0
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnCount) }
    var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(imageNames, id: \.self) { imageName in
                ZStack(alignment: .top) {
                    SampleViews.image(for: imageName)
                        .squared()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(cornerRadius)
        }
}

struct SquareImagesGrid_Previews: PreviewProvider {
    static var previews: some View {
        let imageNames = SampleData.sampleImageNames(count: 12)
        SquareImagesGrid(imageNames: imageNames, columnCount: 3)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 600, height: 800))
            .previewDisplayName("Square Images Grid")
            .padding(40)
    }
}
