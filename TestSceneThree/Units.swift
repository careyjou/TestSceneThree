//
//  Units.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import SwiftUI

struct Units : View {
    @State var isSmActive = true
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 0) {
                    ZStack {
                        if self.isSmActive == true {
                            Color.black.opacity(0.1)
                        }
                        Text("cm")
                            .foregroundColor(.white)
                        
                    }.frame(width: 70)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.isSmActive = true
                    }
                    
                    ZStack {
                        if self.isSmActive == false {
                            Color.black.opacity(0.1)
                        }
                        Text("mm")
                            .foregroundColor(.white)
                        
                    }.frame(width: 70)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.isSmActive = false
                    }
                    
                    
                }.frame(width: 140, height: 36)
                .background(Blurview())
                .cornerRadius(6)
                Spacer()
            }
            Spacer()
        }.padding(.vertical, 36)
        .padding(.leading, 36)
    }
}

