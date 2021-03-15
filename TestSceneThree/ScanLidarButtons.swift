//
//  ScanLidarButtons.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//



import SwiftUI



struct ScanLidarButtons : View {
    var body: some View {
        ZStack {
            
            /// Top buttons
            VStack {
                TopScannerButtons()
                Spacer()
            }
            
            
            /// Right buttons
            HStack {
                Spacer()
                ToolsButtons()
            }
            .padding(.top, 74)
            
            
            /// Units
            HStack {
                Units()
                Spacer()
            }.padding(.top, 74)
            
            
            /// Change view
            ChangeScannerView()
            
        }
    }
}
