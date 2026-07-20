import SwiftUI

enum AppTypography {
    // MARK: - Headings (Poppins via system font)

    static let title1: Font = .system(size: 32, weight: .bold, design: .default)
    static let title2: Font = .system(size: 24, weight: .semibold, design: .default)
    static let title3: Font = .system(size: 18, weight: .semibold, design: .default)

    // MARK: - Body (system .body with Dynamic Type support)

    static let body: Font = .body
    static let bodyEmphasis: Font = .system(.body, design: .default).weight(.semibold)
    static let caption: Font = .caption
    static let captionEmphasis: Font = .system(.caption, design: .default).weight(.semibold)

    // MARK: - Helpers for Dynamic Type

    static func headline(size: CGFloat = 24) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }

    static func button(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }
}

// Note: Google Fonts (Poppins, Inter) are handled via:
// 1. Download from fonts.google.com
// 2. Add .ttf files to Xcode project under Fonts folder
// 3. Register in Info.plist under UIAppFonts
// For now, we use system fonts (.default design) as fallback.
// When you add custom fonts, update these to reference them.
