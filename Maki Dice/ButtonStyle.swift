//  Maki Dice (iOS)
//  github.com/andrewmichaelpowell

import SwiftUI

extension View {
	@ViewBuilder
	func diceButtonStyle(tint: Color? = nil) -> some View {
		if #available(iOS 26.0, *) {
			buttonStyle(.glass(.regular.tint(tint?.opacity(1.0))))
		} else {
			buttonStyle(.borderedProminent)
				.tint(tint ?? Color(.secondarySystemBackground))
		}
	}
}
