//
//  HeaderView.swift
//  HandyChatGPT
//
//  Created by Trudy on 2023/04/28.
//

import SwiftUI

struct HeaderView: View {
    
    var body: some View {
        HStack(spacing: 20) {
            Image("robot")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .background(Color("lightblue"))
    }
}
