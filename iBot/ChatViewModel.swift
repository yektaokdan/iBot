//
//  ChatViewModel.swift
//  iBot
//
//  Created by yekta on 13.03.2024.
//

import Foundation
extension ChatView{
    class ViewModel:ObservableObject{
        @Published var messages:[Message] = []
        @Published var currentInput : String = ""
        private let openAIService = OpenAIService()
        func sendMessage(){
            let newMessage = Message(id:UUID(), role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
            Task{
                let response = await openAIService.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else{
                    print("Had no recieved message")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
                await MainActor.run{
                    messages.append(receivedMessage)
                }
                
            }
        }
    }
}

struct Message{
    let id : UUID
    let role:SenderRole
    let content: String
    let createAt:Date
}
