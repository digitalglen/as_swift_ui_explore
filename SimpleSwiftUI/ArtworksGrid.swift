import SwiftUI

struct ArtworksGrid: View {
    let model: ArtworksGridDataModel
    let showAsPurchased: Bool
    
    init(_ model: ArtworksGridDataModel, showAsPurchased: Bool) {
        self.model = model
        self.showAsPurchased = showAsPurchased
    }
    init(_ bundle: SampleBundle, showAsPurchased: Bool) {
        self.model = ArtworksGridDataModel(bundle)
        self.showAsPurchased = showAsPurchased
    }

    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        SampleViews.image(for: model.imageName)
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .font( .body)
//            .background(.black)
            .cornerRadius(8)

            HStack {
                VStack {
                    Text(model.title)
                        .foregroundColor( Color( UIColor.label ) )
                    Text(model.price)
                        .foregroundColor( Color( UIColor.label.withAlphaComponent(0.325)) )
                        .opacity( showAsPurchased ? 0 : 1)
                }
            }
//            .background(.orange)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ArtworksGrid_Previews: PreviewProvider {
    static var previews: some View {
        ArtworksGrid(SampleData.sampleBundle, showAsPurchased: false)
            .previewLayout(.fixed(width: 250, height: 340))
//            .previewLayout(.sizeThatFits)
//            .background(.blue)
            .padding([.all], 20)
            .preferredColorScheme(.dark)
    }
}
