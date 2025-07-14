import SwiftUI

struct FortuneView: View {
    let fortune: String
    @ObservedObject var viewModel: FortuneViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Fortune")
                .font(.largeTitle)
            Text(fortune)
                .padding()
                .font(.title2)
                .multilineTextAlignment(.center)

            Button("Try Again") {
                viewModel.restartQuiz()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.pink)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}