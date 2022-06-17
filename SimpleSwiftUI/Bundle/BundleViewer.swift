import SwiftUI

struct BundleViewer: View {
    let model: ViewModel.Bundle
    
    var body: some View {
        BundleViewerGrid(model: model)
            .navigationBarTitle(model.title)
    }
}

struct BundleViewer_Previews: PreviewProvider {
    static var previews: some View {
        BundleViewer(model: ViewModel.Bundle(SampleData.bundle))
            .preferredColorScheme(.dark)
    }
}
