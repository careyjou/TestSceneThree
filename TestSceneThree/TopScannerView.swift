//
//  TopScannerView.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//


import SwiftUI

struct TopScannerButtons: View {
    var body: some View {
        ZStack {
            HStack(alignment: .bottom) {
                //                    Group {
                TopScannerButton(icon: "icon_xmark", action: {
                    
                }).padding(.leading, 25)
                .padding(.trailing, 36)
                
                TopScannerButton(icon: "icon_info", action: {
                    
                }).padding(.trailing, 36)
                
                TopScannerButton(icon: "icon_share_white", action: {
                    
                })
                
                Spacer()
                
                RoomPicker()
                    .padding(.trailing, 36)
                
            }.frame(height: 74)
            .background(Blurview())
            
            
            //scan to CAD
            VStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image("icon_scan_box_white")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                        
                        Text("Scan to CAD")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                    }
                })
            }.padding(.bottom)
            
        }.frame(height: 74)
    }
}

struct TopScannerButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopScannerButtons()
    }
}
