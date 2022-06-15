import SwiftUI

struct PurchaseSheet_Grid_3x4: View, PurchaseSheetDesign {
    @ObservedObject var state: StoreState
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2, alignment: .center), count: 3)
    var bundle: SampleBundle {state.purchaseSheetBundle}
    var artworks: [SampleArtwork] {bundle.artworks}

    var body: some View {
        VStack {
            VStack {
                HStack {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(artworks, id: \.self) { sampleArtwork in
                            VStack {
                                if let image = sampleArtwork.imageSquare {
                                    image
//                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fill)
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
    }
    
    var thumbnailCellsWide: Double {3.0}
    var thumbnailCellsTall: Double {4.0}
    var thumbnailSpacing: Double {2.0}
    var thumbnailSize: CGSize { CGSize(width: 128, height: 128) }
    var thumbnailWidth: CGFloat { (thumbnailSize.width - (thumbnailCellsWide - thumbnailSpacing)) / thumbnailCellsWide }
    var thumbnailHeight: CGFloat { (thumbnailSize.height - (thumbnailCellsTall - thumbnailSpacing)) / thumbnailCellsTall }
    var thumbnailCellSize: CGSize {
        CGSize(width: thumbnailHeight, height: thumbnailHeight)
    }
    var thumbnail: some View {
        VStack(spacing: thumbnailSpacing) {
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(0)
                thumbnailCell(1)
                thumbnailCell(2)
            }
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(3)
                thumbnailCell(4)
                thumbnailCell(5)
            }
            HStack(spacing: thumbnailSpacing) {
                thumbnailCell(6)
                thumbnailCell(7)
                thumbnailCell(8)
            }
            HStack(spacing: thumbnailSpacing) {
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
    func thumbnailCell(_ index: Int) -> some View {
        let image = artworkForIndex(index)?.imageSquare ?? Image("circle.fill")
        return image
            .resizable()
            .aspectRatio(1.0, contentMode: .fill)
            .frame(width: thumbnailCellSize.width, height: thumbnailCellSize.height)
            .background(.white.opacity(0.2))
    }
}

struct PurchaseSheet_Grid_3x4_Previews: PreviewProvider {
    @ObservedObject static var state: StoreState = StoreState()
    static var previews: some View {
        PurchaseSheet_Grid_3x4(state: state)
            .previewLayout(.fixed(width: 600, height: 850))
        PurchaseSheet_Grid_3x4(state: state).thumbnail
            .previewLayout(.fixed(width: 128, height: 128))
    }
}
