import SwiftUI

struct GridOfBundles: View {
    @ObservedObject var state: StoreState
    let bundles: [SampleBundle]
    let showAsPurchased: Bool
    var gridHSpacing: Double {80}
    var gridVSpacing: Double {10}
    var body: some View {
        let bundleColumns = Array(repeating: GridItem(.flexible(), spacing: gridHSpacing, alignment: .center), count: 4)
        ScrollView {
            VStack {
                HStack {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: bundleColumns, spacing: gridVSpacing) {
                        ForEach(bundles, id: \.self) { bundle in
                            GridOfArtworks(state: state, bundle: bundle,
                                           showAsPurchased: showAsPurchased)
                        }
                    }
                    Spacer(minLength: 20)
                }
                .foregroundColor(.gray)
            }
            .padding(20)
        }
    }
}

private struct GridOfArtworks: View {
    @ObservedObject var state: StoreState
    let bundle: SampleBundle
    var artworks: [SampleArtwork] {bundle.artworks}
    let showAsPurchased: Bool
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(artworks, id: \.self) { artwork in
                    GridImage(state: state, artwork: artwork)
                }
            }
            .font( .body)
            .cornerRadius(8)

            Spacer()
            Text(bundle.title)
                .foregroundColor( Color( UIColor.label ) )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if showAsPurchased == false {
                Text("$1.99")
                    .foregroundColor( Color( UIColor.label.withAlphaComponent(0.325)) )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Spacer()
        }
        .onTapGesture {
            withAnimation {
                state.purchaseSheetBundle = bundle
                state.purchaseSheetIsVisible = true
            }
        }
    }
}

struct GridImage: View {
    @ObservedObject var state: StoreState
    let artwork: SampleArtwork
    
    var body: some View {
        artwork.imageSquare
        .resizable()
        .aspectRatio(1, contentMode: .fill)
    }
}

struct GridOfBundles_Previews: PreviewProvider {
    @ObservedObject static var state: StoreState = StoreState()
    static var previews: some View {
        GridOfBundles(state: state, bundles: SampleData.bundles, showAsPurchased: false)
            .preferredColorScheme(.dark)
//        GridOfArtworks(state: state)
//            .preferredColorScheme(.dark)
    }
}
