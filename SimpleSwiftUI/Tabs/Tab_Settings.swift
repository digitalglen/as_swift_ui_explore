import SwiftUI

struct Tab_Settings: View {
    @State var playSounds: Bool = true
    @State var playMusic: Bool = true
    
    var outerPadding: Double {self.isCompact ? 0 : 0}
    var maxWidth: Double {self.isCompact ? .infinity : 600}
    var body: some View {
        NavigationView {
            HStack {
                VStack {
                    Form {
                        Section(header: Text("Preferences")) {
                            Toggle(isOn: $playSounds) {
                                Text("Play Sounds")
                            }
                            Toggle(isOn: $playMusic) {
                                Text("Play Music")
                            }
                        }
                        
                        Section(header: Text("Help")) {
                            NavigationLink(destination: Tab_Today()) {
                                Text("How to Play")
                            }
                            NavigationLink(destination: Tab_Today()) {
                                HStack {
                                    Image(systemName: "envelope")
                                    Text("Send us an email")
                                }
                            }
                        }
                        
                        Section(header: Text("About")) {
                            HStack {
                                Text("Version")
                                Spacer()
                                Text("2.2.1")
                            }
                            .foregroundColor(.secondary)
                        }
                        
                        Section {
                            Button(action: {
                                print("Perform an action here...")
                            }) {
                                Text("Restore Purchases")
                            }
                        }
                    }
                    //                .background( Color.ui.background )
                }
            }
            .padding(outerPadding)
            .frame(maxWidth: self.maxWidth)
            .navigationTitle("Settings")
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Tab_Settings_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Settings()
            .previewDisplayName("Settings")
    }
}

