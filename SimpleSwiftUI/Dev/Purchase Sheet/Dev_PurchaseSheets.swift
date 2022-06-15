import SwiftUI

struct Dev_PurchaseSheets: View {
    @ObservedObject var state: StoreState = StoreState()
    var body: some View {
        NavigationView {
            VStack {
                PurchaseSheetDesigns(state: state)
                    .navigationTitle("Purchase Sheets")
                PurchaseSheet(state: state, darkBehind: false)
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


fileprivate struct PurchaseSheetDesigns: View {
    
    @ObservedObject var state: StoreState = StoreState()
    let columns = Array(repeating: GridItem(.flexible(), spacing: 8, alignment: .bottom), count: 6)
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(PurchaseSheetStyleKind.allCases, id: \.self) { kind in
                    PurchaseSheetDesignTile(style: kind.style) {
                        state.purchaseSheetStyle = kind.style.kind
                        withAnimation {
                            state.purchaseSheetIsVisible = true
                        }
                    }
                }
            }
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

fileprivate struct PurchaseSheetDesignTile: View {
    let style: PurchaseSheetStyle
    let onTap: (() -> (Void))
    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 8) {
                switch style.kind {
                case .grid3x4:      PurchaseSheet_Grid_3x4(state: StoreState()).thumbnail
                case .hero10:       PurchaseSheet_Hero10(state: StoreState()).thumbnail
                case .gridTopHero:  PurchaseSheet_Grid_TopHero(state: StoreState()).thumbnail
                }
                Text(style.title)
                Text(style.subtitle)
                    .foregroundColor(.secondary)
            }
        }
        .foregroundColor(.white)
        .aspectRatio(1.0, contentMode: .fill)
//        .frame(width: 250, height: 250)
        .onTapGesture {
            onTap()
        }
    }
}

struct Dev_PurchaseSheets_Previews: PreviewProvider {
    static var previews: some View {
        Dev_PurchaseSheets()
    }
}
