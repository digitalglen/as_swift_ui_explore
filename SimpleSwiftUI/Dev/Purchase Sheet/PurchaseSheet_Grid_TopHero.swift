import SwiftUI

struct PurchaseSheet_Grid_TopHero: View, PurchaseSheetDesign {
    @ObservedObject var state: StoreState
    @State var selectedArtwork: SampleArtwork? = nil
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2, alignment: .center), count: 4)
    var bundle: SampleBundle {state.purchaseSheetBundle}
    var artworks: [SampleArtwork] {bundle.artworks}

    init(state: StoreState) {
        self.state = state
        selectedArtwork = artworks.first
    }
    var body: some View {
        VStack {
            HStack {
                heroImage(artwork: selectedArtwork ?? artworks.first)
            }
            VStack {
                HStack {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(artworks, id: \.self) { artwork in
                            VStack {
                                gridImage(artwork: artwork, isHero: selectedArtwork == nil || selectedArtwork == artwork) {
                                    selectedArtwork = artwork
                                }
                            }
                        }
                    }
                }
                .font( .system(size: 80))
                .foregroundColor(.gray)
            }
            ZStack(alignment: .center) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(bundle.title)
                            .font(.headline)
                        Text("\(artworks.count) new puzzles")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    Spacer()
                    Button("$1.99") {
                    }
                    .background {
                        LinearGradient(stops: [
                            Gradient.Stop(color: .blue.opacity(0.5), location: 0.0),
                            Gradient.Stop(color: .blue.opacity(1.0), location: 0.5),
                        ], startPoint: .bottom, endPoint: .top)
                    }
                    .foregroundColor(.primary)
                    .cornerRadius(8)
                    .buttonStyle(.bordered)
                }
                .padding(20)

                VStack {
                    Image(systemName: "chevron.compact.down")
                        .onTapGesture {
                            withAnimation {
                                state.purchaseSheetIsVisible.toggle()
                            }
                        }
                    .foregroundColor(.gray)
                    .font(.largeTitle)
                    .padding(20)
                }
                Spacer(minLength: 16)
            }
            Spacer(minLength: 20)
        }
        .preferredColorScheme(.dark)
        .frame(maxWidth: 500, maxHeight: .infinity)
    }
    
    struct heroImage: View {
        let artwork: SampleArtwork?
        var body: some View {
            HStack {
                if let image = artwork?.imageLarge {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                }
            }
            .aspectRatio(1.0, contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
    
    struct gridImage: View {
        let artwork: SampleArtwork
        let isHero: Bool
        let onTap: (() -> Void)
        var body: some View {
            artwork.imageSquare
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .opacity( isHero ? 1.0 : 0.5)
                .onTapGesture {
                    onTap()
                }
        }
    }
    
    var thumbnailCellsWide: Double {return 4.0}
    var thumbnailCellsTall: Double {return 7.0}
    var thumbnailSpacing: Double {2.0}
    var thumbnailSize: CGSize { CGSize(width: 128, height: 128) }
    var thumbnailWidth: CGFloat { (thumbnailSize.width - (thumbnailCellsWide - thumbnailSpacing)) / thumbnailCellsWide }
    var thumbnailHeight: CGFloat { (thumbnailSize.height - (thumbnailCellsTall - thumbnailSpacing)) / thumbnailCellsTall }
    var thumbnailHeroCellSize: CGSize {
        CGSize(width: thumbnailCellSize.width * 4 + (2 * thumbnailSpacing),
               height: thumbnailCellSize.height * 4 + (2 * thumbnailSpacing))
    }
    var thumbnailCellSize: CGSize {
        CGSize(width: thumbnailHeight, height: thumbnailHeight)
    }
    var thumbnail: some View {
        VStack(spacing: thumbnailSpacing) {
            HStack(spacing: thumbnailSpacing) {
                heroThumbnailCell
            }
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(0)
                thumbnailCell(1)
                thumbnailCell(2)
                thumbnailCell(3)
            }
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(4)
                thumbnailCell(5)
                thumbnailCell(6)
                thumbnailCell(7)
            }
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(8)
                thumbnailCell(9)
                thumbnailCell(10)
                thumbnailCell(11)
            }
        }
        .foregroundColor(.gray)
        .preferredColorScheme(.dark)
    }
    
    func artworkForIndex(_ index: Int) -> SampleArtwork? {
        (index < artworks.count) ? artworks[index] : nil
    }
    
    var heroThumbnailCell: some View {
        let image = artworkForIndex(0)?.imageSquare ?? Image("circle.fill")
        return image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: thumbnailHeroCellSize.width, height: thumbnailHeroCellSize.height)
            .background(.white.opacity(0.3))
    }
    func thumbnailCell(_ index: Int) -> some View {
        let image = artworkForIndex(index)?.imageSquare ?? Image("circle.fill")
        return image
            .resizable()
            .aspectRatio(1.0, contentMode: .fill)
            .frame(width: thumbnailCellSize.width, height: thumbnailCellSize.height)
            .background(.white.opacity(0.2))
    }
}

struct PurchaseSheet_Grid_TopHero_Previews: PreviewProvider {
    @ObservedObject static var state: StoreState = StoreState()
    static var previews: some View {
        PurchaseSheet_Grid_TopHero(state: state)
            .previewLayout(.fixed(width: 600, height: 850))
        PurchaseSheet_Grid_TopHero(state: state).thumbnail
            .previewLayout(.fixed(width: 128, height: 128))
    }
}
