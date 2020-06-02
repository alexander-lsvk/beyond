//
//  ChatViewModel.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import Foundation
import Combine
import AVKit

final class ChatViewModel: ObservableObject {
    var messages = [Message]()

    @Published var publishedMessages = [Message]()

    private let delay = 0.5

    private let didUpdateMessagesHandler = PassthroughSubject<Void, Never>()

    private let speechService: SpeechService
    private let dataDecoderService: DataDecoderService

    init(speechService: SpeechService = BeyondSpeechService(),
         dataDecoderService: DataDecoderService = BeyondDataDecoderService()) {
        self.speechService = speechService
        self.dataDecoderService = dataDecoderService

        loadData()
    }
}

extension ChatViewModel {
    private func loadData() {
        dataDecoderService.decode(jsonFileName: "chat") { [weak self] (result: Result<[Message], Error>) in
            switch result {
            case .success(let response):
                if !response.isEmpty {
                    self?.messages = response
                    self?.showMessagesAfterDelay(index: 0)
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    private func showMessagesAfterDelay(index: Int) {
        publishedMessages.append(messages[index])
        speechService.play(text: messages[index].body, with: delay) { [weak self] in
            guard let self = self else {
                return
            }
            if index < self.messages.count - 1 {
                self.showMessagesAfterDelay(index: index + 1)
            }
        }
    }
}

