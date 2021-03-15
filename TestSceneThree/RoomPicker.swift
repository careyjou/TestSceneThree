//
//  RoomPicker.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import SwiftUI

struct RoomPicker : View {
    //session current project rooms
    @State var currentRoom = 0
    @State var rooms = ["Kitchen", "Bedroom", "Kitchen", "Kitchen", "Kitchen", "Kitchen"]
    var body: some View {
        Menu {
//            List {
            ForEach(0..<rooms.count) { index in
                Button(rooms[index], action: {
                    self.currentRoom =  index
                })
            }
            
        } label: {
            HStack {
                Text(self.rooms[currentRoom])
                    .foregroundColor(.white)
                Image(systemName: "chevron.down.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 14, height: 14)
            }
                .padding(10)
        }
    }
}
