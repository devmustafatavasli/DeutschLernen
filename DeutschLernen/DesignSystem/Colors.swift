import SwiftUI

enum AppColor {
    // MARK: - Semantic Colors (light & dark modes via Asset Catalog)

    // Use these as fallback; actual colors defined in Asset Catalog (Colors.xcassets/*)
    // This ensures automatic dark mode + accessibility support

    static let background = Color("Background")
    static let surface = Color("Surface")
    static let surfaceSecondary = Color("SurfaceSecondary")

    // Primary: vibrant, Duolingo-inspired green for learning progress
    static let primary = Color("Primary")

    // Accent: warm orange for highlights, CTAs, important moments
    static let accent = Color("Accent")

    // Text hierarchy
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let textTertiary = Color("TextTertiary")

    // Semantic: success (correct answer, box progression)
    static let success = Color("Success")

    // Semantic: error (wrong answer, negative feedback)
    static let error = Color("Error")

    // Card backgrounds for Leitner boxes (distinct but cohesive)
    static let cardLight1 = Color("CardLight1")
    static let cardLight2 = Color("CardLight2")
    static let cardLight3 = Color("CardLight3")
    static let cardLight4 = Color("CardLight4")
    static let cardLight5 = Color("CardLight5")
}

// Setup: Create a ColorSet in Assets.xcassets for each color name above.
// Each ColorSet should have Appearance: Light, Dark variants so they adapt automatically.
//
// Color values (to add to Xcode Color Sets):
// - Background: Light #FAFAFC, Dark #1C1C1F
// - Surface: Light #FFFFFF, Dark #2A2A2C
// - SurfaceSecondary: Light #F7F7FA, Dark #383839
// - Primary: Light #218B4D (learning green), Dark #28A745
// - Accent: Light #FD9A1C (warm orange), Dark #FFB84D
// - TextPrimary: Light #212127, Dark #F0F0F5
// - TextSecondary: Light #858591, Dark #B3B3BB
// - TextTertiary: Light #B5B5C0, Dark #8D8D96
// - Success: Light #3DC278 (correct), Dark #50E0A0
// - Error: Light #F24436 (wrong), Dark #FF6B63
// - CardLight1-5: warm, cool, sky, sunny, lavender tints (light mode)
//   In dark mode, these auto-invert to complementary tones via Xcode's color set inverter
