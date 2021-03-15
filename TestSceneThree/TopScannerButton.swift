//
//  TopScannerButton.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import SwiftUI

struct TopScannerButton : View {
    var icon: String
    var action: () -> Void
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
               
            }, label: {
                Image(self.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            })
            .padding(.bottom)
        }
    }
}
