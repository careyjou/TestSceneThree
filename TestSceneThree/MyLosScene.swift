//
//  MyLosScene.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 13.03.2021.
//

import SwiftUI

import RealityKit
import SceneKit
import ARKit

import MetalKit
import ModelIO
import SceneKit.ModelIO


struct Touch {
    var x : Float
    var y : Float
    var z : Float
    var existsTouch : Bool
    var node : SCNNode
    
    init(){
    x = 0
    y = 0
    z = 0
    existsTouch = false
    node = SCNNode()
    }
    
    init(x1: Float, y2 : Float, z2: Float){
        self.x = x1
        self.y = y2
        self.z = z2
        existsTouch = false
        node = SCNNode()
    }
    
    mutating func clean(){
        self.x = 0
        self.y = 0
        self.z = 0
        existsTouch = false
    }
    
    mutating func addValueTouch(x1: Float, y1: Float, z2: Float){
        self.x = x1
        self.y = y1
        self.z = z2
    }
    
    func removeThisNode(){
        self.node.removeFromParentNode()
    }
    
    mutating func addValueTouch(vec: SCNVector3){
        self.x = vec.x
        self.y = vec.y
        self.z = vec.z
    }
    
    
}




struct MySceneA : UIViewRepresentable {
    
    var sceneE  = SCNScene(named: "srcscene.scnassets/scene.scn")
  
    
    var touchOne : Touch = Touch()
    var touchTwo : Touch = Touch()
    var lineNodes = SCNNode()
    
    
    let sceneMains = ARSCNView()
    let meshMaterial = SCNMaterial()
    var ScanEnale = false
    private var knownAnchors = Dictionary<UUID, SCNNode>()
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    mutating func callSimple1(){
        print(" simple call 1 !!")
        
        if(ScanEnale){
            ScanEnale = false
        }else{
            ScanEnale = true
        }
    }
    
    
    func startScanningCameras(){
        print( "start scanning cames ! press " )
    }
     
    final class Coordinator : NSObject, ARSCNViewDelegate{
        var controlL : MySceneA
        
        
        init(_ control :  MySceneA ){
            
            self.controlL = control
            super.init()
        }
        
        
        func firstFuncTouch(anotherTouch: SCNVector3?){
            controlL.touchOne.existsTouch = true
             
            controlL.touchOne.addValueTouch(vec: anotherTouch ?? SCNVector3(0.0, 0.0, 0.0))
        }
        
        
        func DrawLines(){
            
            let vert : [SCNVector3] =  [SCNVector3(x: controlL.touchOne.x, y:controlL.touchOne.y , z:controlL.touchOne.z ), SCNVector3(x:controlL.touchTwo.x, y: controlL.touchTwo.y, z: controlL.touchTwo.z)]
            
            
          //  x: SIMD3<Float>, _ y: SIMD3<Float>) -> Float
            let from = SIMD3<Float>(SCNVector3(controlL.touchOne.x, controlL.touchOne.y, controlL.touchOne.z))
            let to = SIMD3<Float>(SCNVector3(controlL.touchTwo.x, controlL.touchTwo.y, controlL.touchTwo.z))
            let distanceLos = distance(from, to)
            print(" my distance on saved == \(distanceLos)")
            
            
            let vertSou = SCNGeometrySource(vertices: vert)
            print(" my vertor to draw == \(vert)")
            
            let colors : [UInt8] = [ 235, 3, 252, 155, 1, 1, 1, 1]
            let colorData = Data(colors) // was init(bytes: ) deprecated
            let colorCourse = SCNGeometrySource(data: colorData, semantic: .color, vectorCount: colors.count, usesFloatComponents: false , componentsPerVector: 4, bytesPerComponent: 1, dataOffset: 0, dataStride: 4)
            
            
            
            let indices : [UInt8] = Array(0..<2)
            let pointCloud = SCNGeometryElement(indices: indices, primitiveType: .line)
            pointCloud.pointSize = 2.4
            
            pointCloud.minimumPointScreenSpaceRadius = 10
            pointCloud.maximumPointScreenSpaceRadius = 16
            
            //let geomLos =
            let geom = SCNGeometry(sources: [vertSou, colorCourse], elements: [pointCloud])
            
            let materil = SCNMaterial()
            materil.diffuse.contents = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            materil.ambient.contents = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            
            
            geom.firstMaterial?.diffuse.contents = UIColor.purple
            
            
            
            
    //        let winner = SKLabelNode(fontNamed: "Chalkduster")
    //        winner.text = "You Win!"
    //        winner.fontSize = 65
    //        winner.fontColor = SKColor.green
    //        winner.position = CGPoint(x: 300, y: 200)
               
            //sceneMain?.rootNode.addChildNode(winner)
            
            
            let newText = SCNText(string: " my \(distanceLos) ", extrusionDepth: 1)
            let mat = SCNMaterial()
            mat.diffuse.contents = UIColor.magenta
            newText.materials = [mat]
            
    //          newText.font = UIFont (name: "Arial", size: 3)
    //       newText.firstMaterial!.diffuse.contents = UIColor.white
    //       newText.firstMaterial!.specular.contents = UIColor.white

            //_textNode = SCNNode()
//            _textNode.position = SCNVector3(x:-4.0, y:4.02, z:-0.1)
//            _textNode.scale = SCNVector3(x:0.1, y:0.1, z:0.1)
//            _textNode.geometry = newText
            
//            controlL.sceneMains.scene.rootNode.addChildNode(_textNode)
            
          
            controlL.lineNodes.geometry = geom
            controlL.sceneMains.scene .rootNode.addChildNode(controlL.lineNodes)
            
        }
        
        
        
        
        
        
        @objc func myTapIsOk(_ gesture : UIGestureRecognizer){
        // or UITapGestureRecognizer
        
            print(" call my Gesture 1! \(gesture.numberOfTouches) ")
            
            let p = gesture.location(in: self.controlL.sceneMains)
            
            print(" my p == \(p)")
            
            let ae = gesture.location(in: controlL.sceneMains)
           
            
            let hitResults = controlL.sceneMains.hitTest(ae, options: [:])
            print(" my hitResult == \(String(describing: hitResults.count))")
            
            if  (hitResults.count  > 0 ) {
                print(" greater's ")
                
                let vert : [SCNVector3] =  [SCNVector3(x: Float(hitResults[0].worldCoordinates.x ), y: Float(hitResults[0].worldCoordinates.y ), z: Float(hitResults[0].worldCoordinates.z ))]
                
                let vertSou = SCNGeometrySource(vertices: vert)
                print(" my vertor to draw == \(vert)")
            
                
                let colors : [UInt8] = [ 235, 3, 252, 155]
                //let newColors: [Float] = [0.87, 0.11, 0.98, 0.5]
                let colorData = Data(colors) // was init(bytes: ) deprecated
                let colorCourse = SCNGeometrySource(data: colorData, semantic: .color, vectorCount: colors.count, usesFloatComponents: false , componentsPerVector: 4, bytesPerComponent: 1, dataOffset: 0, dataStride: 4)
                
                let indices : [UInt8] = Array(0..<1)
                let pointCloud = SCNGeometryElement(indices: indices, primitiveType: .point)
                pointCloud.pointSize = 0.1
                pointCloud.minimumPointScreenSpaceRadius = 2
                pointCloud.maximumPointScreenSpaceRadius = 10
                
                let geom = SCNGeometry(sources: [vertSou, colorCourse], elements: [pointCloud])
                
                let materil = SCNMaterial()
                materil.diffuse.contents = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                geom.firstMaterial = materil
                geom.firstMaterial?.diffuse.contents = UIColor.purple   // main color
                
                
                if(!controlL.touchOne.existsTouch && !controlL.touchTwo.existsTouch){
                     print(" no my touch ")
                    controlL.touchOne.existsTouch = true
                    firstFuncTouch(anotherTouch: hitResults[0].worldCoordinates)
                    
                    controlL.touchOne.node.geometry = geom
                    controlL.sceneMains.scene.rootNode.addChildNode(controlL.touchOne.node)
                    
                
                }else if(controlL.touchOne.existsTouch && !controlL.touchTwo.existsTouch){

                    controlL.touchTwo.existsTouch = true
                    controlL.touchTwo.addValueTouch(vec: hitResults[0].worldCoordinates )
                     
                    
                    
                    // DestroyLines
                    print( " all touch is existings " )
                    controlL.touchTwo.node.geometry = geom
                    //posinCloudNodes.geometry = geom
                    controlL.sceneMains.scene.rootNode.addChildNode(controlL.touchTwo.node)

                    DrawLines()
                    
                    //sceneMain?.rootNode.enumerateChildNodes{ ()}
          
                     
                }else{
                    controlL.touchOne.existsTouch = false
                    controlL.touchTwo.existsTouch = false
                    // DestroyLines
                    print( " all touch is existings " )
    //                sceneMain?.rootNode.enumerateChildNodes{ (posinCloudNodes, stop) in
    //                    posinCloudNodes.removeFromParentNode()
    //
    //                }
                  //  posinCloudNodes.removeFromParentNode()
                    controlL.touchOne.removeThisNode()
                    controlL.touchTwo.removeThisNode()
                    controlL.lineNodes.removeFromParentNode()
                  
                    //_textNode.removeFromParentNode()
                    
                    //sceneMain?.rootNode.removeFromParentNode()
                    //firstFuncTouch(anotherTouch: hitResults?[0].worldCoordinates)
                }
                
                
                
//                firstFuncTouch(anotherTouch: hitResults[0].worldCoordinates)
//                controlL.touchOne.node.geometry = geom
//                controlL.sceneMains.scene.rootNode.addChildNode(controlL.touchOne.node)
                
            }
        
       }
        
        
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            print(" we are add ")

            
            var sceneNode: SCNNode?

            if let meshAnchor = anchor as? ARMeshAnchor {
                let geometry = SCNGeometry.makeFromMeshAnchor(meshAnchor, materials: [self.controlL.meshMaterial])
                sceneNode = SCNNode(geometry: geometry)
            }

            if let node = sceneNode {
                node.simdTransform = anchor.transform
                controlL.knownAnchors[anchor.identifier] = node
                self.controlL.sceneMains.scene.rootNode.addChildNode(node)
            }
        }


        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
             print(" adding a 01")
            
            
            print(" ok added")
            if let node =  self.controlL.knownAnchors[anchor.identifier] {
                if let meshAnchor = anchor as? ARMeshAnchor {
                    node.geometry = SCNGeometry.makeFromMeshAnchor(meshAnchor, materials: [controlL.meshMaterial])
                }
                node.simdTransform = anchor.transform
            }
        
        }



        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

            print(" newly add node For")
                let sdfwe = SCNNode()
             return sdfwe

        }
        
        
        
    }
    
    
     func makeUIView(context: Context) ->
      ARSCNView {
        
        
        sceneMains.allowsCameraControl = true
        
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
        sceneE?.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        sceneE?.rootNode.addChildNode(ambientLightNode)
        
        
        
        sceneMains.showsStatistics = true
        sceneMains.scene = sceneE!

        let conf = ARWorldTrackingConfiguration()

        sceneMains.session.run(conf)
        sceneMains.delegate = context.coordinator
        
        
        let ges = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.myTapIsOk(_:)))
        
        sceneMains.addGestureRecognizer(ges)
        
        return sceneMains
    }
    
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        
        print(" update my scene ")
        
        if(ScanEnale){
            
            let conf = ARWorldTrackingConfiguration()
            conf.sceneReconstruction = .mesh
            conf.environmentTexturing = .automatic
    
            let image = UIImage(named: "srcscene.scnassets/aaa.jpg")!
            meshMaterial.diffuse.contents = image
            meshMaterial.diffuse.wrapS = .repeat
            meshMaterial.diffuse.wrapT = .repeat
            meshMaterial.emission.contents = UIColor.black
            // constant
            meshMaterial.lightingModel = .physicallyBased
            meshMaterial.blendMode = .alpha
    
            meshMaterial.shaderModifiers = [
                .geometry:geometryShaderModi
            ]
    
    
            sceneMains.session.run(conf)
            sceneMains.delegate = context.coordinator
            
        }else{
           
            let conf = ARWorldTrackingConfiguration()
         
            sceneMains.session.run(conf)
            sceneMains.delegate = context.coordinator
            
        }
        
    }
}



struct MyLosScene: View {
    
    @EnvironmentObject var LidarLos : LidarView
    
    var body: some View {
        ZStack{
            LidarLos.sceneLos
            
            ScanLidarButtons().edgesIgnoringSafeArea(.top)
        }
     
        
    }
}

struct MyLosScene_Previews: PreviewProvider {
    static var previews: some View {
        MyLosScene()
    }
}
