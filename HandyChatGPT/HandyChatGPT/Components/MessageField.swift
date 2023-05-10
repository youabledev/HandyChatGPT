//
//  MessageField.swift
//  HandyChatGPT
//
//  Created by Trudy on 2023/05/02.
//

import SwiftUI

struct MessageField: View {
    @State private var message = ""
    var sendButtonAction: (String) -> Void // 버튼 동작을 위한 클로저
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("ChatGPT에게 무엇이든 물어보세요!"), text: $message)
            
            Button {
                 sendButtonAction(message) // 버튼 동작 클로저 호출
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color("lightblue"))
                    .cornerRadius(50)
            }

        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(Color("gray"))
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField(sendButtonAction: {_ in })
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    
    // parameter에서 on만 때서 클로져로 전달
    var editingChanged: (Bool) -> () = { _ in }
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            // x, y 가 아닌 z 축으로 UI가 쌓임
            if text.isEmpty {
                placeholder.opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
