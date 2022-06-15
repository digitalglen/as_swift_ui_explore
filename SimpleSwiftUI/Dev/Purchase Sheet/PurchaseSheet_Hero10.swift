import SwiftUI

struct PurchaseSheet_Hero10: View, PurchaseSheetDesign {
    @ObservedObject var state: StoreState
    @State var selectedArtwork: SampleArtwork? = nil
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2, alignment: .center), count: 3)
    var bundle: SampleBundle {state.purchaseSheetBundle}
    var artworks: [SampleArtwork] {bundle.artworks}
    
    init(state: StoreState) {
        self.state = state
        selectedArtwork = artworks.first
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                imageGrid(width: geometry.size.width, height: geometry.size.height)
            }
            bottomBar(state: state)
            Spacer()
            bottomChevron(state: state)
//                Spacer(minLength: 16)
        }
        .preferredColorScheme(.dark)
    }
    
    struct bottomBar: View {
        @ObservedObject var state: StoreState
        var body: some View {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(state.purchaseSheetBundle.title)
                        .font(.title)
                    Text("\(state.purchaseSheetBundle.artworks.count) new puzzles")
                        .font(.body)
                        .foregroundColor(.secondary)
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
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            .padding(20)

        }
    }
    
    struct bottomChevron: View {
        @ObservedObject var state: StoreState
        var body: some View {
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
        }
    }

    var gridSpacing: Double {4.0}

    var thumbnailCellsWide: Double {return 5.0}
    var thumbnailCellsTall: Double {return 5.0}
    var thumbnailSpacing: Double {return 2.0}
    var thumbnailSize: CGSize { CGSize(width: 128, height: 128) }
    var thumbnailHeroCellSize: CGSize {
        CGSize(width: thumbnailCellSize.width * 4 + (3 * thumbnailSpacing),
               height: thumbnailCellSize.height * 4 + (3 * thumbnailSpacing))
    }
    var thumbnailCellSize: CGSize {
        CGSize(width: (thumbnailSize.width - (thumbnailCellsWide - thumbnailSpacing)) / thumbnailCellsWide,
               height: (thumbnailSize.height - (thumbnailCellsTall - thumbnailSpacing)) / thumbnailCellsTall)
    }
    func imageGrid(width: CGFloat, height: CGFloat) -> some View {
        VStack(spacing: gridSpacing) {
            HStack(alignment: .top, spacing: gridSpacing) {
                imageHeroCell(selectedArtwork ?? artworks.first)
                VStack(spacing: gridSpacing) {
                    imageCell(artworks[1])
                    imageCell(artworks[2])
                    imageCell(artworks[3])
                    imageCell(artworks[4])
                }
            }
            HStack(alignment: .top, spacing: gridSpacing) {
                imageCell(artworks[5])
                imageCell(artworks[6])
                imageCell(artworks[7])
                imageCell(artworks[8])
                imageCell(artworks[9])
            }
        }
//        .aspectRatio(1.0, contentMode: .fit)
        .background(.black)
        .foregroundColor(.gray)
        .frame(maxWidth: width, maxHeight: width)
        .preferredColorScheme(.dark)
    }
    
    var thumbnail: some View {
        VStack(spacing: thumbnailSpacing) {
            HStack(spacing: thumbnailSpacing) {
                heroThumbnailCell
                VStack(spacing: thumbnailSpacing) {
                    thumbnailCell(0)
                    thumbnailCell(1)
                    thumbnailCell(2)
                    thumbnailCell(3)
                }
            }
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(4)
                thumbnailCell(5)
                thumbnailCell(6)
                thumbnailCell(7)
                thumbnailCell(0)
            }
        }
        .foregroundColor(.gray)
        .preferredColorScheme(.dark)
    }

    func artworkForIndex(_ index: Int) -> SampleArtwork? {
        guard (index < artworks.count) else {return nil}
        return artworks[index]
    }
    func imageHeroCell(_ artwork: SampleArtwork?) -> some View {
        HStack {
            if let image = artwork?.imageLarge {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(.white.opacity(0.3))
            }
        }
        .aspectRatio(1.0, contentMode: .fill)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
    func imageCell(_ artwork: SampleArtwork) -> some View {
        artwork.imageSquare
        .resizable()
        .aspectRatio(1.0, contentMode: .fit)
        .background(.white.opacity(0.2))
        .opacity(selectedArtwork == nil || selectedArtwork == artwork ? 1.0 : 0.5)
        .onTapGesture {
            selectedArtwork = artwork
        }
    }
    
    var heroThumbnailCell: some View {
        let image = artworkForIndex(0)?.imageSquare ?? Image("circle.fill")
        return image
            .resizable()
            .frame(width: thumbnailHeroCellSize.width, height: thumbnailHeroCellSize.height)
            .background(.white.opacity(0.3))
    }
    func thumbnailCell(_ index: Int) -> some View {
        let image = artworkForIndex(index)?.imageSquare ?? Image("circle.fill")
        return image
            .resizable()
            .frame(width: thumbnailCellSize.width, height: thumbnailCellSize.height)
            .background(.white.opacity(0.2))
    }
}

struct PurchaseSheet_Hero10_Previews: PreviewProvider {
    @ObservedObject static var state: StoreState = StoreState()
    static var previews: some View {
        PurchaseSheet_Hero10(state: state)
            .previewLayout(.fixed(width: 600, height: 850))
//        PurchaseSheet_Hero10(state: state).thumbnail
//            .previewLayout(.fixed(width: 128, height: 128))
    }
}
