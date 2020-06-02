//
//  MessageView.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import SwiftUI

struct MessageView: View {
    private let messageBodyLength = 300
    @State var opacity = 0.0

    var message: Message

    var body: some View {
        Group {
            HStack(alignment: .bottom, spacing: 0) {
                drawMessageViewTriangle(width: 13.0, height: 18.0)

                Text(message.body.prefix(messageBodyLength))
                    .padding(10)
                    .background(Color("messageBackground"))
                    .cornerRadius(5.0)
                    .shadow(color: .gray, radius: 2.0, x: 1.0, y: 1.0)
            }
        }
        .padding(EdgeInsets(top: 30.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        .opacity(self.opacity)
        .onAppear {
            return withAnimation(.linear(duration: 0.5)) {
                self.opacity = 1
            }
        }
    }

    private func drawMessageViewTriangle(width: CGFloat, height: CGFloat) -> some View {
       Path { path in
            path.move(to: CGPoint(x: 0, y: height - 3.0))
            path.addLine(to: CGPoint(x: width, y: height - 3.0))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.closeSubpath()
        }
       .fill(Color("messageBackground"))
       .shadow(color: .gray, radius: 2.0, x: 0, y: 1.0)
       .frame(width: width, height: height)
       .clipped()
       .zIndex(2)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(body: "Hello friends!"))
    }
}

