//
//  SpeechService.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import Foundation
import AVKit

protocol SpeechService {
    func play(text: String, with delay: Double, didFinishHandler: @escaping () -> Void)
}

final class BeyondSpeechService: NSObject, SpeechService {
    private var didFinishHandler: (() -> Void)?

    private let speechSynthesizer: AVSpeechSynthesizer

    override init() {
        self.speechSynthesizer = AVSpeechSynthesizer()
        super.init()

        self.speechSynthesizer.delegate = self
    }

    func play(text: String, with delay: Double, didFinishHandler: @escaping () -> Void) {
        self.didFinishHandler = didFinishHandler

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let speechUtterance = AVSpeechUtterance(string: text)

            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            self.speechSynthesizer.speak(speechUtterance)
        }
    }
}

extension BeyondSpeechService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        didFinishHandler?()
    }
}
