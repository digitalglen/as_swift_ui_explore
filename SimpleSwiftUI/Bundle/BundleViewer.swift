import SwiftUI

struct BundleViewer: View {
    let bundle: SampleBundle
    var body: some View {
        ZStack(alignment: .top) {
            ArtworksGrid(model: ArtworksGridViewModel(bundle), showAsPurchased: true)

            VStack {
                Text("HELLO")
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .background(Material.bar)
//                    .background(.black.opacity(0.75))
            }
        }
        .navigationBarTitle(bundle.title)
        .background(ignoresSafeAreaEdges: [.horizontal])
    }
}

struct BundleViewer_Previews: PreviewProvider {
    static var previews: some View {
        BundleViewer(bundle: SampleData.sampleBundle)
            .preferredColorScheme(.dark)
    }
}
