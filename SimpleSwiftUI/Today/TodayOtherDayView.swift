import SwiftUI

struct TodayOtherDayView: View {
    let daysPast: Int
    let imageName: String
    let starCount: Int
    var roundedCorners: UIRectCorner = []
    
    let secondsInDay: TimeInterval = 60*60*24
    var dayOfWeek: Date {
        Date().advanced(by: -1 * (secondsInDay * TimeInterval(daysPast)))
    }
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                SampleViews.image(for: imageName)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                VStack {
                    StarsView(starCount: starCount)
                }
            }
            .cornerRadius(8, corners: roundedCorners)
            HStack {
                Spacer()
                Text(dayOfWeek, format: Date.FormatStyle().weekday(.abbreviated))
                Spacer()
            }
            .font( Font.system(size: 22, weight: .regular))
            .foregroundColor(.white.opacity(0.6))
        }
    }
}

struct StarsView: View {
    let starCount: Int
    var backgroundColor: Color {starCount == 0 || starCount > 3 ? .clear : .black.opacity(0.6) }
    var starImage: Image { Image(systemName: "star.fill") }
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Spacer()
                switch starCount {
                case 1:
                    starImage
                case 2:
                    starImage
                    starImage
                case 3:
                    starImage
                    starImage
                    starImage
                default:
                    starImage
                        .foregroundColor(.clear)
                }
                Spacer()
            }
            .padding(.vertical, 6)
        }
        .background(backgroundColor)
        .foregroundColor(.primary)
    }
}

struct TodayOtherDayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayOtherDayView(daysPast: 1, imageName: SampleViews.placeholderImageName, starCount: 2)
            .previewLayout(.fixed(width: 600, height: 500))
            .preferredColorScheme(.dark)
            .previewDisplayName("Today - Past Day")
            .padding(20)

        StarsView(starCount: 0)
            .previewLayout(.fixed(width: 150, height: 20))
            .preferredColorScheme(.dark)
            .previewDisplayName("No stars")
        StarsView(starCount: 1)
            .previewLayout(.fixed(width: 150, height: 20))
            .preferredColorScheme(.dark)
            .previewDisplayName("1 star")
        StarsView(starCount: 2)
            .previewLayout(.fixed(width: 150, height: 20))
            .preferredColorScheme(.dark)
            .previewDisplayName("2 stars")
        StarsView(starCount: 3)
            .previewLayout(.fixed(width: 150, height: 20))
            .preferredColorScheme(.dark)
            .previewDisplayName("3 stars")
        StarsView(starCount: 4)
            .previewLayout(.fixed(width: 150, height: 20))
            .preferredColorScheme(.dark)
            .previewDisplayName("4 stars")
    }
}
