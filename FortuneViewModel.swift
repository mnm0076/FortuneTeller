import Foundation

class FortuneViewModel: ObservableObject {
    @Published var currentIndex = 0

    let questions: [String] = [
        "Have you made eye contact with a mannequin this month?",
        "Did you eat anything beige today?",
        "Have you touched grass in the past 48 hours?",
        "Are your socks currently matching?",
        "Have you made any odd Amazon purchases this week?",
        "Have you said 'slay' out loud in the last 24 hours?",
        "Did you microwave something and forget about it?",
        "Are you currently sitting at a desk or table with your computer in front of you?",
        "Have you worn sunglasses indoors recently?",
        "Did you pet an animal that did not belong to you this week?",
        "Have you opened TikTok more than 3 times today?",
        "Have you stood in front of the fridge without grabbing anything?",
        "Did you say 'I'm gonna start eating clean' and then immediately forget?",
        "Have you ignored a text for no reason today?",
        "Have you given unsolicited advice in the past 72 hours?",
        "Did you wear pants with no real pockets recently?",
        "Have you eaten something directly out of the container today?",
        "Have you considered legally changing your name just for a bit?",
        "Did you compliment someone while secretly judging their outfit?"
    ].shuffled()

    let cursedFortunes = [
        "Avoid synchronized blinking with strangers today.",
        "Refrain from petting any ceramic frogs before 5 PM.",
        "Do not trust anyone offering you lukewarm pudding.",
        "Today is not the day to touch moss recreationally.",
        "Abstain from humming near open windows.",
        "Don’t eat anything described as ‘moist’ and ‘unlabeled.’",
        "If you see an open bag of Funyuns, turn around and walk away.",
        "Now is not the time to purchase pink and white striped socks.",
        "Avoid stirring any soup clockwise after sunset.",
        "Do not accept homemade salsa from Amelia.",
        "Stay away from folding chairs in public spaces today.",
        "Let the geese win.",
        "Do not watch more than three YouTube videos in a row about marbles.",
        "Avoid touching any gelatinous object.",
        "If someone offers you a single green Skittle, say no.",
        "Do not trust any bread that’s warm but dry.",
        "This is not the week to visit a wax museum.",
        "Refrain from wearing mittens indoors.",
        "Do not make direct eye contact with inflatable holiday décor.",
        "If you smell butter and no one’s cooking, evacuate immediately."
    ]

    let encouragingFortunes = [
        "You should consider getting into karate soon.",
        "Compliment someone’s orange shoelaces today. It will ripple.",
        "This is an excellent week to start collecting antique Russian spoons.",
        "The stars approve of you eating red grapes in public.",
        "Now is a good time to learn what a carburetor does.",
        "You’re spiritually aligned to buy a lava lamp.",
        "Now would be a perfect time to learn a new line dance.",
        "Trust the man that says 'howdy' on a bad day.",
        "You're going to get a free slushie soon.",
        "Today is a good day to be a silly goose.",
        "You are ready to buy a set of Tupperware.",
        "Your next parallel parking job will be your best.",
        "You're going to come across a really cool rock this week. Don't lose it.",
        "Start waving to squirrels again. They’ve noticed."
    ]

    func answerQuestion() {
        currentIndex += 1
    }

    func generateRandomFortune() -> String {
        return Bool.random() ? cursedFortunes.randomElement()! : encouragingFortunes.randomElement()!
    }
}
