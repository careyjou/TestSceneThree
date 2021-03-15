//
//  ContentView.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 13.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text(" Go scene 1 ")
                NavigationLink(
                    destination: MyLosScene().environmentObject(LidarView())
                ) {
                    Text(" Go scene ! ")
                  }
            }
           
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
