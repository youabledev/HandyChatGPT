//
//  ContentView.swift
//  HandyChatGPT
//
//  Created by Trudy on 2023/04/28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HeaderView()
                ScrollViewReader { value in
                    ScrollView {
                        ForEach(viewModel.messages, id: \.self) { message in
                            MessageBubble(dataSource: message)
                        }
                        .onChange(of: viewModel.messages) { _ in
                            value.scrollTo(viewModel.messages.count - 1)
                        }
                    }
                }
                .padding(.top, 10)
                .background(.white)
            }
            .background(Color("lightblue"))
            
            MessageField(sendButtonAction: { message in
                viewModel.logMessage(message, messageUserType: .user)
                viewModel.sendToAssistant()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
