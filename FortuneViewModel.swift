import Foundation

struct ZodiacSign: Codable {
    let name: String
    let start: String
    let end: String
}

struct FortuneResponse: Codable {
    let signs: [ZodiacSign]
    let encouragingFortunes: [String]
    let cursedFortunes: [String]
}

class FortuneViewModel: ObservableObject {
    @Published var userBirthday: Date = Date()
    @Published var zodiacSign: String = ""
    @Published var fortune: String = ""

    private var signs: [ZodiacSign] = []
    private var encouragingFortunes: [String] = []
    private var cursedFortunes: [String] = []

    func fetchFortunes() {
        guard let url = URL(string: "https://mocki.io/v1/7d5316f4-9f65-4613-9628-0fb5fc9193dd") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(FortuneResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.signs = decoded.signs
                        self.encouragingFortunes = decoded.encouragingFortunes
                        self.cursedFortunes = decoded.cursedFortunes
                        self.zodiacSign = self.determineZodiac(for: self.userBirthday)
                        self.fortune = self.generateRandomFortune()
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }

    private func determineZodiac(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        let calendar = Calendar.current
        let birthString = formatter.string(from: date)

        for sign in signs {
            if let start = formatter.date(from: sign.start),
               let end = formatter.date(from: sign.end) {
                let birth = formatter.date(from: birthString)!
                if sign.start > sign.end {
                    if birth >= start || birth <= end {
                        return sign.name
                    }
                } else {
                    if birth >= start && birth <= end {
                        return sign.name
                    }
                }
            }
        }
        return "Unknown"
    }

    private func generateRandomFortune() -> String {
        return Bool.random() ? encouragingFortunes.randomElement() ?? "" : cursedFortunes.randomElement() ?? ""
    }
}
