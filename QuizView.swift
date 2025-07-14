import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel = FortuneViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.currentIndex < viewModel.questions.count {
                Text(viewModel.questions[viewModel.currentIndex])
                    .padding()
                    .font(.headline)
                    .multilineTextAlignment(.center)

                HStack {
                    Button("Yes") {
                        viewModel.answerQuestion()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("No") {
                        viewModel.answerQuestion()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            } else {
                NavigationLink(destination: FortuneView(fortune: viewModel.generateRandomFortune(), viewModel: viewModel)) {
    Text("Reveal Your Fortune")
        .padding()
        .background(Color.purple)
        .foregroundColor(.white)
        .cornerRadius(10)
}
            }
        }
        .padding()
    }
}