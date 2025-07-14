import SwiftUI

struct ContentView: View {
    @State private var startQuiz = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to the Fortune App")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: QuizView(), isActive: $startQuiz) {
                    EmptyView()
                }

                Button("Begin Quiz") {
                    startQuiz = true
                }
                .padding()
                .background(Color.pink)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}