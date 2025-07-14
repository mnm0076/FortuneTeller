import SwiftUI

struct FortuneView: View {
    let fortune: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Fortune")
                .font(.largeTitle)
            Text(fortune)
                .padding()
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}