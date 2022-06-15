
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
                TodayPane(settings: settings)
                TodayBeforeView()
            }
            .frame(width: 850.0)
            Spacer()
        }
        .background(bgColor)
    }
}

struct TodayPane: View {
    @ObservedObject var settings: TodaySettings
    var imageData: UIImage { UIImage(named: "brueghel_large")! }
    var imagePiecesData: UIImage { UIImage(named: "brueghel_pieces")! }
    var body: some View {
        let imageData = UIImage.imageWithImage(imageData, scaledAndCroppedToSize: CGSize(width: 850, height: 850), orientation: .center)!
        VStack {
            HStack {
                Text(Date(), format: Date.FormatStyle().month().day().weekday(.wide))
            }
            .font( Font.system(size: 36, weight: .regular))
            .foregroundColor(.white.opacity(0.75))
            HStack {
                ZStack {
                    Image(uiImage: imageData)
                        .blur(radius: 30)
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

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
    }
}








