//
//  ChatView.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import SwiftUI

struct Message: Decodable, Hashable {
    var body: String
}

struct ChatView: View {
    @State var yOffset: CGFloat = -100.0

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()

        UITableViewCell.appearance().backgroundColor = .clear
    }

    @EnvironmentObject var chatViewModel: ChatViewModel

    var body: some View {
        List {
            ForEach(chatViewModel.publishedMessages.reversed(), id: \.self) { message in
                MessageView(message: message)
                    .modifier(FlippedUpsideDown())
                    .padding(.leading, 12)
                    .padding(.trailing, 20)
            }
        }
        .modifier(FlippedUpsideDown())
        .listRowInsets(EdgeInsets(top: 50.0, leading: 0.0, bottom: 50.0, trailing: 0.0))
        .background(Color("background"))
        .id(UUID())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(ChatViewModel())
    }
}
