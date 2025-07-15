import Foundation
import SwiftUI

class FortuneViewModel: ObservableObject {
    @Published var userBirthday = Date()
    @Published var zodiacSign = ""
    @Published var loveFortune = ""
    @Published var careerFortune = ""
    @Published var mysticFortune = ""
    @Published var tarotCardName = ""
    @Published var tarotCardMeaning = ""

    var allFortunes: FortuneData?

    func fetchDailyFortunes() {
        guard let url = URL(string: "https://mocki.io/v1/f7e8f113-a158-4eea-af33-fe7b927ca2c6") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(FortuneData.self, from: data)

                    DispatchQueue.main.async {
                        self.allFortunes = result
                        self.zodiacSign = self.getZodiacSign(from: self.userBirthday)

                        let seed = self.generateSeedForTodayAndBirthday()
                        var generator = SeededGenerator(seed: seed)

                        self.loveFortune = result.loveFortunes.randomElement(using: &generator) ?? ""
                        self.careerFortune = result.careerFortunes.randomElement(using: &generator) ?? ""
                        self.mysticFortune = result.mysticFortunes.randomElement(using: &generator) ?? ""

                        if let tarot = result.tarotCards.randomElement(using: &generator) {
                            self.tarotCardName = tarot.name
                            self.tarotCardMeaning = tarot.meaning
                        }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }

    private func generateSeedForTodayAndBirthday() -> UInt64 {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let todayString = formatter.string(from: Date())
        formatter.dateFormat = "yyyyMMdd"
        let birthdayString = formatter.string(from: userBirthday)
        let combined = todayString + birthdayString
        return UInt64(combined) ?? UInt64(Date().timeIntervalSince1970)
    }

    func getZodiacSign(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: date)
        guard let month = components.month, let day = components.day else { return "" }

        for sign in zodiacSigns {
            if (month == sign.startMonth && day >= sign.startDay) || (month == sign.endMonth && day <= sign.endDay) {
                return sign.name
            }
        }

        return "Unknown"
    }

    let zodiacSigns: [(name: String, startMonth: Int, startDay: Int, endMonth: Int, endDay: Int)] = [
        ("Capricorn", 12, 22, 1, 19),
        ("Aquarius", 1, 20, 2, 18),
        ("Pisces", 2, 19, 3, 20),
        ("Aries", 3, 21, 4, 19),
        ("Taurus", 4, 20, 5, 20),
        ("Gemini", 5, 21, 6, 20),
        ("Cancer", 6, 21, 7, 22),
        ("Leo", 7, 23, 8, 22),
        ("Virgo", 8, 23, 9, 22),
        ("Libra", 9, 23, 10, 22),
        ("Scorpio", 10, 23, 11, 21),
        ("Sagittarius", 11, 22, 12, 21)
    ]
}

struct FortuneData: Codable {
    let loveFortunes: [String]
    let careerFortunes: [String]
    let mysticFortunes: [String]
    let tarotCards: [TarotCard]
}

struct TarotCard: Codable {
    let name: String
    let meaning: String
}

struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed
    }

    mutating func next() -> UInt64 {
        self.state = self.state &* 6364136223846793005 &+ 1
        return self.state
    }
}

