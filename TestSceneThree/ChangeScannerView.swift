//
//  ChangeScannerView.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import SwiftUI

struct ChangeScannerView : View {
    var body: some View {
        
        
        HStack {
            VStack {
                Spacer()
                ZStack {
                    HStack {
                        
                        VStack {
                            
                            Spacer()
                            Image("login_2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 110)
                                .clipped()
                                .cornerRadius(6)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
                            Image("icon_swap")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                            Spacer()
                        }
                    }
                    
                    
                }.frame(width: 190, height: 130)
            }
            Spacer()
        }
        
        
        
        .padding(.vertical, 36)
        .padding(.leading, 36)
    }
}

