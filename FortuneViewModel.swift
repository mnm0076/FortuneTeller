import Foundation

struct FortuneData: Codable {
    let questions: [String]
    let cursed: [String]
    let encouraging: [String]
}

class FortuneViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var questions: [String] = []
    @Published var cursedFortunes: [String] = []
    @Published var encouragingFortunes: [String] = []

    init() {
        fetchData()
    }

    func fetchData() {
        guard let url = URL(string: "https://mocki.io/v1/b579192f-cf58-4868-9f54-d957605263c2") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(FortuneData.self, from: data)
                    DispatchQueue.main.async {
                        self.cursedFortunes = decoded.cursed
                        self.encouragingFortunes = decoded.encouraging
                        self.questions = decoded.questions.shuffled().prefix(5).map { $0 }
                    }
                } catch {
                    print("Decoding failed: \(error)")
                }
            } else if let error = error {
                print("HTTP error: \(error)")
            }
        }.resume()
    }

    func answerQuestion() {
        currentIndex += 1
    }

    func restartQuiz() {
        currentIndex = 0
        questions.shuffle()
        questions = questions.prefix(5).map { $0 }
    }

    func generateRandomFortune() -> String {
        return Bool.random()
            ? cursedFortunes.randomElement() ?? "The stars are unusually quiet today."
            : encouragingFortunes.randomElement() ?? "Something curious is in your favor."
    }
}
