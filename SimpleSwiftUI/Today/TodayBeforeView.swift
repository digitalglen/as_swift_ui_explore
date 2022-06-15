import SwiftUI

struct TodayBeforeViewModel {
    struct Day: Identifiable {
        enum Position {case first, middle, last}
        let daysPast: Int
        let imageName: String
        let starCount: Int
        var position: Position = .middle
        var roundedCorners: UIRectCorner {
            switch position {
            case .first: return [.topLeft, .bottomLeft]
            case .middle: return []
            case .last: return [.topRight, .bottomRight]
            }
        }
        var id: Int {daysPast}
    }
    let days: [Day]
    static var sample: TodayBeforeViewModel {
        TodayBeforeViewModel(days: [
            Day(daysPast: 1, imageName: "today_1", starCount: 3, position: .first),
            Day(daysPast: 2, imageName: "today_2", starCount: 2),
            Day(daysPast: 3, imageName: "today_3", starCount: 0),
            Day(daysPast: 4, imageName: "today_4", starCount: 3),
            Day(daysPast: 5, imageName: "today_5", starCount: 3),
            Day(daysPast: 6, imageName: "today_6", starCount: 1, position: .last),
        ])
    }
}

struct TodayBeforeView: View {
    let model: TodayBeforeViewModel = .sample
    var body: some View {
        VStack {
            Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    VStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Previous".uppercased())
                                    .kerning(6)
                                    .font( Font.system(size: 16, weight: .bold))
                                    .frame(alignment: .leading)
                                    .foregroundColor(.white.opacity(0.75))
                            }
                            HStack(alignment: .bottom, spacing: 2) {
                                ForEach(model.days) { day in
                                    TodayOtherDayView(daysPast: day.daysPast, imageName: day.imageName, starCount: day.starCount, roundedCorners: day.roundedCorners)
                                        .frame(maxWidth: 150)
                                }
                            }
                        }
                    }
                    Spacer()
            }
                .padding(40)
//                .background(.pink)
                .background(.white.opacity(0.1))
                .cornerRadius(32.0)
        }
    }
}

struct TodayBeforeView_Previews: PreviewProvider {
    static var previews: some View {
        TodayBeforeView()
            .previewLayout(.fixed(width: 800, height: 400))
            .preferredColorScheme(.dark)
            .padding(40)
    }
}
