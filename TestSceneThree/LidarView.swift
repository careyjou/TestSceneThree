//
//  LidarView.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import SwiftUI


class LidarView: ObservableObject {
    
    
//    @Published var currentProject
//    @Published var currentRoom
    @Published var toolsButtonsArray = [ToolsButtonItem(icon: "icon_3d", type: .changeView, isActive: false),
                                        ToolsButtonItem(icon: "icon_camera", type: .camera, isActive: false),
                                        ToolsButtonItem(icon: "icon_comment", type: .comment, isActive: false),
                                        ToolsButtonItem(icon: "icon_ruler", type: .ruler, isActive: false),
                                        ToolsButtonItem(icon: "icon_move", type: .move, isActive: false),
                                        ToolsButtonItem(icon: "icon_block", type: .lock, isActive: false),
                                        ToolsButtonItem(icon: "icon_delete_white", type: .delete, isActive: false)]
    
    @Published var valueDouble: Double = 0
    // MARK: - tools button, right
    @Published var sceneLos = MySceneA() // was SceneKitView
    
     // camera Up view's
    func toolChange3d() {
      //  sceneLos.cameraUpViews()
        sceneLos.callSimple1()
    }
    
     
    func toolCamera() {
      //  sceneLos.toolsCameraV()s
        sceneLos.startScanningCameras()
    }
    
    func toolComment() {
        
    }
    
    func toolRuler() {
        
    }
    
    func toolMove() {
        
    }
    
    func toolBlock() {
        
    }
    
    func toolDelete() {
        
    }
    
    func changeActive(index: Int) {
        
        //check if active
        let indexCheck = self.toolsButtonsArray.firstIndex(where: {$0.isActive == true})
        
        if index == indexCheck {
            for i in 0..<self.toolsButtonsArray.count {
                self.toolsButtonsArray[i].isActive = false
            }
            return
        }
        
        for i in 0..<self.toolsButtonsArray.count {
            self.toolsButtonsArray[i].isActive = false
        }
        self.toolsButtonsArray[index].isActive = true
    }
    
}

