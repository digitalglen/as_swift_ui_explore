import SwiftUI

struct ArtworksGrid: View {
    let model: ArtworksGridViewModel
    let showAsPurchased: Bool
    
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        SampleViews.image(for: model.imageName)
                            .squared()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .font( .body)
            .cornerRadius(8)
            HStack {
                VStack {
                    Text(model.title)
                        .foregroundColor( .primary )
                    Text(model.price)
                        .foregroundColor( .secondary )
                        .opacity( showAsPurchased ? 0 : 1)
                }
            }
        }
    }
}

struct ArtworksGrid_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtworksGridViewModel(SampleData.sampleBundle)
        ArtworksGrid(model: model, showAsPurchased: false)
            .previewLayout(.fixed(width: 250, height: 500))
            .padding([.all], 20)
            .preferredColorScheme(.dark)
    }
}
