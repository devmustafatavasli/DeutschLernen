# Design System: Philosophy & Guidelines

## Philosophy

**DeutschLernen** uses a design language inspired by:

1. **Duolingo's approachability** — friendly, playful, encouraging without being childish
2. **Minimalism** — every element serves a purpose; remove visual noise
3. **Learning science** — design reinforces spaced repetition:
   - Progress is visible (color progression through Leitner boxes)
   - Feedback is immediate (green for correct, red for wrong, animated)
   - Daily habit is encouraged (simple, satisfying interactions)
4. **Apple's Human Interface Guidelines** — predictable, accessible, respectful of user attention

## Design Tokens

### Colors (`Colors.swift`)

**Semantic, not literal.** Every color has a purpose:
- **Primary (Green)**: learning progress, success states, CTA emphasis
- **Accent (Orange)**: highlights, important moments, alternative CTAs
- **Success/Error**: immediate, unambiguous feedback in test mode
- **Text Hierarchy**: primary, secondary, tertiary for information density
- **Cards**: five distinct, warm tones for Leitner box visual differentiation (boxes 1-5)

**Dark mode built-in**: Every color auto-adapts via Xcode's Color Sets (light/dark variants).

### Typography (`Typography.swift`)

**System fonts with Dynamic Type support.** No fixed pixel sizes; users can scale.
- **Titles**: `.semibold`, size hierarchy for information structure
- **Body**: `.body` system style for legibility and accessibility
- **Emphasis**: `.semibold` body for callouts within text

*Future: Add custom Google Fonts (Poppins for personality, Inter for body clarity) by:
1. Download .ttf files from fonts.google.com
2. Drag into Xcode's Fonts folder
3. Add to Info.plist under UIAppFonts
4. Update Typography.swift to reference custom fonts*

### Spacing (`Spacing.swift`)

**Consistent rhythm.** All padding, margins, and gaps use these values:
- `xs`-`xxl`: 4, 8, 12, 16, 24, 32 points (multiples of 4 for clean rhythm)
- Buttons & inputs: 48pt height (comfortable tap targets)
- Cards: 16pt padding (breathing room, minimal waste)

## Application per Screen

### Entries (List & Stack)

- **Cards**: use 5 card colors (rotating based on Leitner box)
- **Spacing**: `lg` padding on cards, `md` gaps between cards
- **Text**: `.title3` for Turkish, `.body` for German
- **Minimal adornment**: cards stand on their own, no borders or shadows (just color)

### Test Mode

- **Feedback**: immediate color change (surface → success green or error red)
- **Emphasis**: `.title2` for Turkish (larger than list, focuses attention)
- **Gesture**: haptic feedback on swipe (Duolingo-inspired encouragement)

### Forms (Add/Edit)

- **Input height**: `formInputHeight` (48pt, Apple standard)
- **Spacing**: `xl` between fields, `lg` for section gaps
- **Button**: full-width, `buttonHeight`, `.accent` color for save CTA

### Settings

- **List style**: clean, list rows with `md` spacing
- **Type scale**: `.body` for explanations, `.caption` for hints
- **No visual clutter**: let white space breathe

### Widget

- **Inherit card colors** from main app (same 5-color palette)
- **Minimal text**: Turkish + German only, `.body` sized
- **Next button**: `.accent` color, matches app's CTA language
- **Dark mode ready**: uses semantic colors from Color Sets

## Accessibility Checklist

- [ ] **VoiceOver labels** on every icon-only button
- [ ] **Color contrast** checked (WCAG AA minimum, AAA preferred)
- [ ] **Dynamic Type** tested at Large and Extra Large sizes
- [ ] **Dark mode** tested throughout
- [ ] **Haptic feedback** for important interactions (swipes in test mode, etc.)

## Next Steps

1. Create Color Sets in Assets.xcassets for each semantic color (see `Colors.swift` comment for RGB values)
2. Apply system to each screen (Entries → Test → Settings → Widget)
3. Test light/dark mode and Dynamic Type scaling after each screen
4. Once design is finalized, consider adding custom Google Fonts if needed
