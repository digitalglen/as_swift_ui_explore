import SwiftUI

struct ArtworksGrid: View {
    let model: ArtworksGridDataModel
    let showAsPurchased: Bool
    
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        SampleViews.image(for: model.imageName)
                            .square()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .font( .body)
            .cornerRadius(8)
//            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
//                Color.clear
//                    .frame(height: 60)
//                    .background(Material.bar)
//            }
            HStack {
                VStack {
                    Text(model.title)
                        .foregroundColor( Color( UIColor.label ) )
                    Text(model.price)
                        .foregroundColor( Color( UIColor.label.withAlphaComponent(0.325)) )
                        .opacity( showAsPurchased ? 0 : 1)
                }
            }
        }
    }
}

struct ArtworksGrid_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtworksGridDataModel(SampleData.sampleBundle)
        ArtworksGrid(model: model, showAsPurchased: false)
            .previewLayout(.fixed(width: 250, height: 500))
            .padding([.all], 20)
            .preferredColorScheme(.dark)
    }
}
