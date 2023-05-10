//
//  ChatViewModel.swift
//  HandyChatGPT
//
//  Created by Trudy on 2023/04/28.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    //
    // api info
    private let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")
    private let openAIKey = "api key를 여기에 입력해 주세요"
    
    //
    // combine
    private var subscription: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    @Published var messages: [Message] = [
        Message(role: .system, content: "안녕하세요? 당신의 ChatGPT입니다.")
    ]
    
    func sendToAssistant() {
        guard let url = openAIURL else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        let messagesJSonString: [[String :String]] = messages.compactMap { message in
            return ["role": "user", "content": message.content]
        }
        
        let httpBody: [String: Any] = [
            "model" : "gpt-3.5-turbo",
            "messages" : messagesJSonString
        ]
        
        var httpBodyJson: Data? = nil

        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            logMessage("error", messageUserType: .assistant)
        }
        
        request.httpBody = httpBodyJson
        
        // request
        subscription = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: OpenAIResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("v1/chat/completions error!!! : \(error)")
                }
            }, receiveValue: { [weak self] returnedMessage in
                self?.logMessage(returnedMessage.choices.first?.message["content"] ?? "", messageUserType: .assistant)
                self?.subscription?.cancel()
            })
    }
    
    func logMessage(_ message: String, messageUserType: RoleType) {
        messages.append(
            Message(role: messageUserType, content: message))
    }
}
