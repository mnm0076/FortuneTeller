import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    private(set) var isPlaying = false

    func playMusic() {
        guard !isPlaying else { return }

        if let url = Bundle.main.url(forResource: "fortune_music", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
                isPlaying = true
            } catch {
                print("Error playing music: \(error)")
            }
        }
    }

    func stopMusic() {
        audioPlayer?.stop()
        isPlaying = false
    }

    func toggleMusic() {
        isPlaying ? stopMusic() : playMusic()
    }
}
