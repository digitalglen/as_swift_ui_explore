import SwiftUI

extension View {
    var isCompact: Bool {
        @Environment(\.horizontalSizeClass) var horz: UserInterfaceSizeClass?
        return horz == .compact
    }
}
