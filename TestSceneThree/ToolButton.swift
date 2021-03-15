//
//  ToolButton.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import SwiftUI

struct ToolButton : View {
    @EnvironmentObject var lidarViewModel: LidarView
   
    var index: Int
    var action: () -> Void
    var body: some View {
        
        ZStack {
            if self.lidarViewModel.toolsButtonsArray[index].isActive {
                Color.black.opacity(0.1)
            }
            Image(self.lidarViewModel.toolsButtonsArray[index].icon)
                .resizable()
                .scaledToFit()
                .frame(width: 22)
            
        }.frame(width: 60, height: 60)
        .contentShape(Rectangle())
        .onTapGesture {
            self.lidarViewModel.changeActive(index: self.index)
            self.action()
        }
        
    }
    
    
}
