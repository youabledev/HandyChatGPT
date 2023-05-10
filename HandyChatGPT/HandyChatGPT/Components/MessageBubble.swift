//
//  MessageBubble.swift
//  HandyChatGPT
//
//  Created by Trudy on 2023/05/02.
//

import SwiftUI

struct MessageBubble: View {
    // Dependency
    var dataSource: Message
    
    var body: some View {
        VStack(alignment: dataSource.role == .user ? .leading : .leading) {
            HStack {
                Text(dataSource.content)
                    .padding()
                    .foregroundColor(dataSource.role == .user ? .black : .white)
                    .background(dataSource.role == .user ? Color("yellow") : Color("green"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: dataSource.role == .user ? .trailing : .leading)
        }
        .frame(maxWidth: .infinity, alignment: dataSource.role == .user ? .trailing : .leading)
        .padding(dataSource.role == .user ? .trailing : .leading)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(dataSource: Message(role: .assistant, content: "테스트 텍스트"))
    }
}
