import SwiftUI

struct SegmentedControl: View {
    struct Segment: Identifiable {
        let image: Image
        let id: Int
    }
    @State var selectedIndex: Int
    var title: String = ""
    let segments: [Segment]

    init(_ segments: [Segment], selectedIndex: Int = 0) {
        self.segments = segments
        self.selectedIndex = selectedIndex
        let appearance = UISegmentedControl.appearance()
        appearance.selectedSegmentTintColor = .white
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    init(_ images: [Image], selectedIndex: Int = 0) {
        let segments = images.enumerated().map { Segment(image: $1, id: $0) }
        self.init(segments, selectedIndex: selectedIndex)
    }

    var body: some View {
        HStack {
            Spacer()
            Picker(title, selection: $selectedIndex) {
                ForEach(segments) {
                    $0.tag($0.id)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .foregroundColor(.white)
            Spacer()
        }
        .background(.clear)
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    @State static var selectedIndex: Int = 0
    static var previews: some View {
        SegmentedControl([
            "Grid",
            "Detail",
            "List",
        ], selectedIndex: selectedIndex)
        .preferredColorScheme(.dark)
    }
}
