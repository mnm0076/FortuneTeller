import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = FortuneViewModel()
    @State private var showResults = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.15, green: 0.05, blue: 0.3),
                    Color(red: 0.05, green: 0.02, blue: 0.1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Madam Meg Fortune Telling")
                    .font(.custom("Papyrus", size: 35))
                    .foregroundColor(.yellow)
                    .shadow(color: .purple, radius: 10)
                    .multilineTextAlignment(.center)
                    .shadow(color: .purple, radius: 8)

                if !showResults {
                    Text("Input your birthday:")
                        .font(.custom("Papyrus", size: 24))
                        .foregroundColor(.white)

                    DatePicker("Enter your birthday:", selection: $viewModel.userBirthday, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: {
                        viewModel.fetchDailyFortunes()
                        showResults = true
                    }) {
                        Text("Reveal My Fortune")
                            .font(.custom("Papyrus", size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple.opacity(0.8))
                            .cornerRadius(12)
                            .shadow(color: .purple, radius: 8)
                    }

                    Text("Disclaimer: This is not a real reading - it's simply for fun.")
                        .font(.custom("Papyrus", size: 10))
                        .foregroundColor(Color.yellow)
                        .multilineTextAlignment(.center)
                    Button("Toggle Music") {
                        AudioManager.shared.toggleMusic()
                    }
                    .font(.custom("Papyrus", size: 18))
                    .foregroundColor(.white)
                    .padding(7)
                    .background(Color.purple.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(color: .purple, radius: 6)
                } else {
                    VStack(spacing: 15) {
                        Text("Based on your birthday:")
                            .font(.custom("Papyrus", size: 22))
                            .foregroundColor(Color.yellow)
                            .shadow(color: .purple, radius: 10)
                            .multilineTextAlignment(.center)
                            .shadow(color: .purple, radius: 8)

                        Text("Love: \(viewModel.loveFortune)")
                            .font(.custom("Papyrus", size: 20))
                            .foregroundColor(.purple)
                            .shadow(color: .purple, radius: 10)
                            .multilineTextAlignment(.center)
                            .shadow(color: .purple, radius: 8)

                        Text("Career: \(viewModel.careerFortune)")
                            .font(.custom("Papyrus", size: 20))
                            .foregroundColor(.yellow)
                            .shadow(color: .purple, radius: 10)
                            .multilineTextAlignment(.center)
                            .shadow(color: .purple, radius: 8)

                        Text("Mystic: \(viewModel.mysticFortune)")
                            .font(.custom("Papyrus", size: 20))
                            .foregroundColor(.purple)
                            .shadow(color: .purple, radius: 10)
                            .multilineTextAlignment(.center)
                            .shadow(color: .purple, radius: 8)

                        Text("Tarot Card: \(viewModel.tarotCardName)")
                            .font(.custom("Papyrus", size: 22))
                            .foregroundColor(.yellow)
                            .shadow(color: .purple, radius: 10)
                            .multilineTextAlignment(.center)
                            .shadow(color: .purple, radius: 8)

                        Text(viewModel.tarotCardMeaning)
                            .font(.custom("Papyrus", size: 20))
                            .foregroundColor(.yellow)
                            .shadow(color: .purple, radius: 10)
                            .multilineTextAlignment(.center)
                            .shadow(color: .purple, radius: 8)

                        Button("Get a different reading") {
                            showResults = false
                            viewModel.zodiacSign = ""
                        }
                        .padding()
                        .font(.custom("Papyrus", size: 20))
                        .foregroundColor(.white)
                        .background(Color.purple.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: .purple, radius: 8)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .onAppear {
            AudioManager.shared.playMusic()
        }
        .onDisappear {
            AudioManager.shared.stopMusic()
        }
    }
}


