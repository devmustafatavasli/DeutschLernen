import SwiftUI

struct EntryCard: View {
    let entry: Entry
    // Saklama işlemi için değer tutuyoruz.
    var isGermanRevealed: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(entry.turkish)
                .font(.title2.weight(.semibold))

            if isGermanRevealed {
                Text(entry.german)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            } else {
                Text("Almancasını düşün, sonra dokun")
                    .font(.title3)
                    .foregroundStyle(.tertiary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .modifier(CardBackground())
    }
}
