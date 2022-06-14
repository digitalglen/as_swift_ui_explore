
import UIKit
import SwiftUI

class TodaySettings: ObservableObject {
    enum ViewKind: Int {case today, store, library}
    enum Today: Int {case mon, tue, wed, thu, fri, sat, sun}
    @Published var today: Today
    @Published var viewKind: ViewKind
    static var standard: TodaySettings {
        TodaySettings(today: .mon, viewKind: .today)
    }
    
    init(today: Today, viewKind: ViewKind) {
        self.today = today
        self.viewKind = viewKind
    }
}

struct Today: View {
    @ObservedObject var settings = TodaySettings.standard
    let bgColor = Color(red: 29/255, green: 29/255, blue: 29/255, opacity: 1.0)
    var body: some View {
        HStack {
            Spacer()
            VStack {
//                ViewSegments(settings: settings)
//                    .frame(width: nil, height: 60.0, alignment: .center)
                HStack {
//                    Spacer(minLength: 25)
                    TodayPane(settings: settings)
//                    Spacer(minLength: 25)
                }
                Spacer(minLength: 30)
                OtherDaysView(settings: settings)
                Spacer(minLength: 50)
            }
            .frame(width: 850.0)
            Spacer()
        }
        .background(bgColor)
    }
}


struct ViewSegments: View {
    @ObservedObject var settings: TodaySettings

    init(settings: TodaySettings) {
        self.settings = settings
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        Spacer(minLength: 200)
        HStack {
            Picker("Difficulty", selection: $settings.viewKind) {
                Text("Today").tag(TodaySettings.ViewKind.today)
                Text("Store").tag(TodaySettings.ViewKind.store)
                Text("Library").tag(TodaySettings.ViewKind.library)
            }
            .pickerStyle(SegmentedPickerStyle())
            .foregroundColor(.white)
//            .background(.white.opacity(0.2))
            .frame(width: 400.0, height: nil, alignment: .center)
        }
        .background(.clear)
    }
}

struct TodayPane: View {
    @ObservedObject var settings: TodaySettings
    var imageData: UIImage { UIImage(named: "brueghel_large")! }
    var imagePiecesData: UIImage { UIImage(named: "brueghel_pieces")! }
    var body: some View {
        let imageData = UIImage.imageWithImage(imageData, scaledAndCroppedToSize: CGSize(width: 850, height: 850), orientation: .center)!
//        let imagePiecesData = UIImage.imageWithImage(imagePiecesData, scaledAndCroppedToSize: CGSize(width: 500, height: 1200), orientation: .center)!
        VStack {
            HStack {
                Text(Date(), format: Date.FormatStyle().month().day().weekday(.wide))
            }
            .font( Font.system(size: 36, weight: .regular))
            .foregroundColor(.white.opacity(0.75))
            HStack {
                ZStack {
                    Image(uiImage: imageData)
    //                    .aspectRatio(contentMode: .fill)
        //                .frame(width: 300.0, height: 300.0, alignment: .center)
        //                .fixedSize()
        //                .scaledToFit()
    //                    .background(VisualEffect(style: .systemThickMaterial))
                        .blur(radius: 30)
        //                .vibrancyEffect()
        //                .vibrancyEffectStyle(.fill)
                        .cornerRadius(32.0)
                    ZStack {
                        Image(uiImage: imagePiecesData)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 800.0, height: 800.0, alignment: .center)
                            .tint(.clear)
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 80.0, height: 80.0, alignment: .center)
                            .foregroundColor(.white.opacity(0.90))
                    }
                    .frame(width: 500.0, height: 500, alignment: .center)
                    .background(.clear)
                }
            }
            .frame(width: 850.0, height: 850.0, alignment: .center)
        }
    }
}

struct OtherDaysView: View {
    @ObservedObject var settings: TodaySettings
    var imageData: UIImage { UIImage(named: "brueghel_large")! }
    var body: some View {
        VStack {
            HStack {
                Text("Previous".uppercased())
                    .kerning(6)
                    .font( Font.system(size: 16, weight: .bold))
                    .frame(alignment: .trailing)
                    .foregroundColor(.white.opacity(0.75))
                Spacer()
            }
            HStack {
                OtherDayView(daysPast: 1, imageName: "today_1", starCount: 3)
                OtherDayView(daysPast: 2, imageName: "today_2", starCount: 2)
                OtherDayView(daysPast: 3, imageName: "today_3", starCount: 0)
                OtherDayView(daysPast: 4, imageName: "today_4", starCount: 3)
                OtherDayView(daysPast: 5, imageName: "today_5", starCount: 3)
                OtherDayView(daysPast: 6, imageName: "today_6", starCount: 1)
            }
        }
        .padding(40)
        .background(.white.opacity(0.1))
        .cornerRadius(32.0)
    }
}

struct OtherDayView: View {
    let daysPast: TimeInterval
    let imageName: String
    let starCount: Int
    var imageData: UIImage { UIImage(named: imageName)! }
    let secondsInDay: TimeInterval = 60*60*24
    var body: some View {
        let spacing: CGFloat = 10
        let fullWidth: CGFloat = 850
        let side: CGFloat = (fullWidth - (spacing * 5))/6
        let imageData = UIImage.imageWithImage(imageData, scaledAndCroppedToSize: CGSize(width: side, height: side), orientation: .center)!
        VStack {
            ZStack {
                Image(uiImage: imageData)
                VStack {
                    Spacer()
                    StarsView(starCount: starCount)
                }
                .frame(width: side, height: side, alignment: .bottom)
            }
            .cornerRadius(16.0)
            HStack {
                Spacer()
                Text(Date().advanced(by: -1 * (secondsInDay * daysPast)), format: Date.FormatStyle().weekday(.abbreviated))
                Spacer()
            }
            .font( Font.system(size: 22, weight: .regular))
            .foregroundColor(.white.opacity(0.6))
        }
    }
}

struct StarsView: View {
    let starCount: Int
    var backgroundColor: Color {starCount == 0 ? .clear : .black.opacity(0.6) }
    var body: some View {
        VStack {
            Spacer()
                .frame(width: nil, height: 4.0)
            
            HStack(spacing: 0) {
                Spacer()
                switch starCount {
                case 1:
                    Image(systemName: "star.fill")
                case 2:
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                case 3:
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                default:
                    Image(systemName: "star.fill")
                        .foregroundColor(.clear)
                }
                Spacer()
            }
            Spacer()
                .frame(width: nil, height: 4.0)
        }
//        .vibrancyEffect()
        .background(backgroundColor)
        .foregroundColor(.white)
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
//            .frame(width: .infinity, height: .infinity, alignment: .center)
    }
}








