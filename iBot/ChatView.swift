//
//  ContentView.swift
//  iBot
//
//  Created by yekta on 13.03.2024.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack{
            ScrollView{
                ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id){message in
                    messageView(message: message)
                }
            }
            HStack{
                TextField("Enter a message..", text: $viewModel.currentInput)
                Button{
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                }
            }
        }
        .padding()
    }
    
    func messageView(message:Message) -> some View{
        HStack{
            if message.role == .user {Spacer()}
            Text(message.content)
            if message.role == .assistan {Spacer()}
        }
    }
}

#Preview {
    ChatView()
}
