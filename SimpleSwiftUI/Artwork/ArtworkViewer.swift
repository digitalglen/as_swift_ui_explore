import Foundation
import SwiftUI

struct ArtworkViewer: View {
    @ObservedObject var state: PuzzleState = PuzzleState()
    @State private var isSharePresented: Bool = false
    let model: ViewModel.Artwork
    var shareText: String {model.title}
    var shareImage: UIImage {model.uiImageLarge!}
    var shareURL: URL {Bundle.main.url(forResource: model.imageLargeName, withExtension: nil)!}
    var body: some View {
        ZStack {
            SampleViews.image(for: model.imageLargeName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .padding(20)

            Overlay(model: model) { target in
                switch target {
                case .play:
                    state.artworkID = model.id
                    state.isPresented = true
                case .share:
                    isSharePresented = true
                }
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $state.isPresented, content: {
            VStack {
                PuzzlePlayer(state: state, model: model)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .sheet(isPresented: $isSharePresented, onDismiss: {
        }, content: {
            ActivityViewController(activityItems: [shareText, shareImage, shareURL])
        })
    }

    struct Overlay: View {
        enum Target {case play, share}
        let model: ViewModel.Artwork
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack(alignment: .center) {
                VStack {
                    ZStack(alignment: .bottom) {
                        VStack {
                            VStack(spacing: 8) {
                                Text("\(model.title)")
                                    .font(.largeTitle)
                                    .foregroundColor(.primary)
                                Text("\(model.artist)")
                                    .font(.title)
                                    .foregroundColor(.secondary)
                                Text("\(model.year)")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                PlayButton(percentCompleted: 0.75) {
                                    onTap(.play)
                                }
                                .padding(.top, 20)
                            }
                            .padding(50)
                            
                        }
                        Toolbar() { target in
                            switch target {
                            case .tiling: break
                            case .share:
                                onTap(.share)
                            }
                        }
                    }
                }
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .frame(maxWidth: 600)
            }
        }
    }
    
    struct RingShape: Shape {
        var percent: Double
        func path(in rect: CGRect) -> Path {
            var start: Double = 0
            var end: Double = percent * 360

            // Start at 12 O-clock instead of 3
            start -= 90
            end -= 90

            var p = Path()
            p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                     radius: rect.size.width/2,
                     startAngle: Angle(degrees: start),
                     endAngle: Angle(degrees: end),
                     clockwise: false)
            return p
        }
        
        
        var animatableData: Double {
            get { return percent }
            set { percent = newValue }
        }
    }

    struct PlayButton: View {
        @State private var percentCalculated: Double = 0
        @State private var buttonScale: Double = 0.95
        var percentCompleted: Double
        let onTap: (() -> Void)
        let outerRingSize: Double = 100
        let progressLineWidth: Double = 10
        var progressRingSize: Double {outerRingSize - progressLineWidth}
        var body: some View {
            ZStack {
                Button(action: {
                    onTap()
                }, label: {
                    Image(systemName: "play.fill")
                        .font( Font.system(size: 50))
                        .foregroundColor(.primary.opacity(buttonScale >= 1.0 ? 1.0 : 0.1))
                        .scaleEffect(x: buttonScale, y: buttonScale)
                })
                
                ZStack {
                    RingShape(percent: 1.0)
                        .stroke(Color.primary.opacity(0.10), lineWidth: progressLineWidth)
                        .frame(width: progressRingSize, height: progressRingSize)
                    RingShape(percent: percentCalculated)
                        .stroke(Color.primary.opacity(0.60), lineWidth: progressLineWidth)
                        .frame(width: progressRingSize, height: progressRingSize)
                }
                .foregroundColor(.primary.opacity(0.5))
            }
            .onAppear() {
                withAnimation(.spring().delay(0.5)) {
                    percentCalculated = percentCompleted
                }
                withAnimation(.easeInOut(duration: 0.1).delay(0.80)) {
                    buttonScale = 1.05
                }
                withAnimation(.easeInOut(duration: 0.1).delay(0.90)) {
                    buttonScale = 1.0
                }
            }
        }
    }
    
    struct Toolbar: View {
        enum Target {case tiling, share}
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack {
                Button(action: {
                    onTap(.tiling)
                }, label: {
                    Image(systemName: "hexagon")
                })
                Spacer()
                Button(action: {
                    onTap(.share)
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            .foregroundColor(.primary)
            .padding(20)
        }
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(model: ViewModel.Artwork(SampleData.randomArtwork))
    }
}
