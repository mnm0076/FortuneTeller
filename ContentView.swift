import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FortuneViewModel()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.15, green: 0.05, blue: 0.3), Color(red: 0.05, green: 0.02, blue: 0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("🔮 Mystic Fortune Teller 🔮")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .purple, radius: 10)

                DatePicker("Enter your birthday:", selection: $viewModel.userBirthday, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Button(action: {
                    viewModel.fetchFortunes()
                }) {
                    Text("Reveal My Fortune")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(color: .purple, radius: 8)
                }

                if !viewModel.zodiacSign.isEmpty {
                    VStack(spacing: 10) {
                        Text("Your Zodiac Sign is: \(viewModel.zodiacSign)")
                            .font(.title2)
                            .foregroundColor(.white)

                        Text(viewModel.fortune)
                            .font(.title3)
                            .foregroundColor(.yellow)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(12)
                            .shadow(color: .yellow, radius: 6)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
