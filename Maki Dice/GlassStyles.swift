//  Maki Dice (iOS)
//  github.com/andrewmichaelpowell

import SwiftUI

extension Color {
	static let makiOrange = Color(
		red: 240 / 255,
		green: 92 / 255,
		blue: 34 / 255
	)
}

extension View {
	@ViewBuilder
	func glassButton(tint: Color? = nil) -> some View {
		if #available(iOS 26.0, *) {
			if let tint {
				buttonStyle(.glassProminent).tint(tint)
			} else {
				buttonStyle(.glass)
			}
		} else {
			buttonStyle(.borderedProminent)
				.tint(tint ?? Color(.secondarySystemBackground))
		}
	}

	@ViewBuilder
	func chooserBackground() -> some View {
		if #available(iOS 26.0, *) {
			glassEffect(.regular.interactive(), in: Capsule())
		} else {
			background(Color(.secondarySystemBackground), in: Capsule())
		}
	}
}

struct SegmentChooser<Value: Hashable>: View {
	@Binding var selection: Value
	let options: [(value: Value, label: LocalizedStringKey)]

	@Namespace private var namespace

	private static var height: CGFloat { 50 }
	private static var inset: CGFloat { 4 }

	var body: some View {
		HStack(spacing: 0) {
			ForEach(options.indices, id: \.self) { index in
				segment(options[index].value, label: options[index].label)
			}
		}
		.padding(Self.inset)
		.frame(height: Self.height)
		.chooserBackground()
		.animation(.snappy, value: selection)
	}

	private func segment(_ value: Value, label: LocalizedStringKey) -> some View
	{
		let isSelected = selection == value
		return Button {
			selection = value
		} label: {
			Text(label)
				.font(.title)
				.foregroundStyle(isSelected ? Color.primary : Color.secondary)
				.lineLimit(1)
				.minimumScaleFactor(0.2)
				.padding(.horizontal, 8)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background {
					if isSelected {
						Capsule()
							.fill(Color.makiOrange)
							.matchedGeometryEffect(
								id: "selection",
								in: namespace
							)
					}
				}
				.contentShape(Capsule())
		}
		.buttonStyle(.plain)
		.accessibilityAddTraits(isSelected ? .isSelected : [])
	}
}
