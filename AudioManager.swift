import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    var player: AVAudioPlayer?

    func playMusic() {
        if let path = Bundle.main.path(forResource: "YourAudioFile", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = -1 // Loop forever
                player?.play()
            } catch {
                print("Error playing music: \(error)")
            }
        }
    }

    func stopMusic() {
        player?.stop()
        player = nil
    }

    func toggleMusic() {
        if let player = player, player.isPlaying {
            stopMusic()
        } else {
            playMusic()
        }
    }
}
