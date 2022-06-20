import SwiftUI

struct BundlesBrowser_List: View {
    let models: [ViewModel.Bundle]
    let showAsPurchased: Bool
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil
    let columns = Array(repeating: GridItem(.flexible(), spacing: 80, alignment: .leading), count: 1)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(models, id: \.self) { model in
                    if onTap == nil {
                        NavigationLink(destination: BundleViewer(model: ViewModel.Bundle(SampleData.bundle(forID: model.id)!))) {
                            Tile(model: model, showAsPurchased: showAsPurchased)
                        }
                    } else {
                        Tile(model: model, showAsPurchased: showAsPurchased)
                            .onTapGesture {
                                onTap?(SampleData.bundle)
                            }
                    }
                }
            }
            .padding(20)
//            .background(.orange.opacity(0.3))
            Spacer(minLength: 20)
        }
//        .frame(width: .infinity, height: .infinity)
        .preferredColorScheme(.dark)
    }
    
    struct Tile: View {
        let model: ViewModel.Bundle
        let showAsPurchased: Bool
        
        var body: some View {
            HStack {
                Text(model.title)
                    .foregroundColor(.primary)
                if showAsPurchased == false {
                    Text(model.price)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct BundlesBrowser_List_Previews: PreviewProvider {
    static var previews: some View {
        let bundles = SampleData.bundles
        let models = bundles.map {ViewModel.Bundle($0)}
        VStack {
            BundlesBrowser_List(models: models, showAsPurchased: false)
        }
            .previewLayout(.fixed(width: 900, height: 520))
            .previewDisplayName("Bundles List")
    }
}
