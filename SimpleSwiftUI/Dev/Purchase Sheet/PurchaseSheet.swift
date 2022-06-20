import SwiftUI

struct PurchaseSheet: View {
    @ObservedObject var state: StoreState
    let darkBehind: Bool

    public init(state: StoreState, darkBehind: Bool = true) {
        self.state = state
        self.darkBehind = darkBehind
    }

    var body: some View {
        Text(" ")
            .foregroundColor(.yellow)
        .sheet(isPresented: $state.purchaseSheetIsVisible, content: {
            VStack {
                switch state.purchaseSheetStyle {
                case .grid3x4:      PurchaseSheet_Grid_3x4(state: state)
                case .hero10:       PurchaseSheet_Hero10(state: state)
                case .gridTopHero:  PurchaseSheet_Grid_TopHero(state: state)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        
        if darkBehind && state.purchaseSheetIsVisible {
            Text("")
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.opacity)
                .background(.black.opacity(0.75))
        }
    }
}

struct PurchaseSheet_Previews: PreviewProvider {
    @ObservedObject static var state: StoreState = StoreState()
    static var previews: some View {
        PurchaseSheet(state: state)
            .previewLayout(.sizeThatFits)
            .ignoresSafeArea()
    }
}
