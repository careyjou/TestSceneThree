//
//  ToolsButtons.swift
//  TestSceneThree
//
//  Created by Сергей Лоскутников on 15.03.2021.
//

import Combine
import Foundation
import SwiftUI

struct ToolsButtonItem : Identifiable {
    let id = UUID()
    var icon: String
    var type: ScanToolsButtonType
    var isActive: Bool
}



struct SwiftUISlider: UIViewRepresentable {

  final class Coordinator: NSObject {
    // The class property value is a binding: It’s a reference to the SwiftUISlider
    // value, which receives a reference to a @State variable value in ContentView.
    var value: Binding<Double>

    // Create the binding when you initialize the Coordinator
    init(value: Binding<Double>) {
      self.value = value
    }

    // Create a valueChanged(_:) action
    @objc func valueChanged(_ sender: UISlider) {
      self.value.wrappedValue = Double(sender.value)
    }
  }

  var thumbColor: UIColor = .white
  var minTrackColor: UIColor?
  var maxTrackColor: UIColor?

  @Binding var value: Double

  func makeUIView(context: Context) -> UISlider {
    let slider = UISlider(frame: .zero)
    slider.thumbTintColor = thumbColor
    slider.minimumTrackTintColor = minTrackColor
    slider.maximumTrackTintColor = maxTrackColor
    slider.value = Float(value)
    let image = resizeImage(image: UIImage(named: "thumb")!, targetSize: CGSize(width: 20, height: 20))
    slider.setThumbImage(image, for: .normal)
    slider.setThumbImage(image, for: .highlighted)

    slider.addTarget(
      context.coordinator,
      action: #selector(Coordinator.valueChanged(_:)),
      for: .valueChanged
    )

    return slider
  }

  func updateUIView(_ uiView: UISlider, context: Context) {
    // Coordinating data between UIView and SwiftUI view
    uiView.value = Float(self.value)
  }

  func makeCoordinator() -> SwiftUISlider.Coordinator {
    Coordinator(value: $value)
  }
}


func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage ?? UIImage(named: "thumb")!
}



enum ScanToolsButtonType {
    case changeView, camera, comment, ruler, move, lock, delete
}

struct ToolsButtons : View {
    
    @EnvironmentObject var lidarViewModel: LidarView
    
    @State var percentage: CGFloat = 0
   // @EnvironmentObject var orientationInfo : OrientationInfo
   
    
    var body: some View {
        VStack {
            
            VStack (spacing: 0) {
                
                ///change 2d/3d view
                ToolButton(index: 0, action: {
                    self.lidarViewModel.toolChange3d()
                })
                
                /// camera
                ToolButton(index: 1, action: {
                    self.lidarViewModel.toolCamera()
                })
                
                /// comment
                ToolButton(index: 2, action: {
                    self.lidarViewModel.toolComment()
                })
                
            }.background(Blurview())
            .cornerRadius(6)
            
            Spacer(minLength: 36)
            
            VStack(spacing: 0) {
                
                /// ruler
                ToolButton(index: 3,  action: {
                    self.lidarViewModel.toolRuler()
                })
                
                /// move
                ToolButton(index: 4,  action: {
                    self.lidarViewModel.toolMove()
                })
                
                /// block
                ToolButton(index: 5,  action: {
                    self.lidarViewModel.toolBlock()
                })
                
                /// delete
                ToolButton(index: 6, action: {
                    self.lidarViewModel.toolDelete()
                })
                
            }.background(Blurview())
            .cornerRadius(6)
            
            Spacer(minLength: 32)
            
            //Slider
//            ZStack {
//
//                VerticalSlider(percentage: $percentage)
//                    .accentColor(.red)
//                    .frame(width: 60)
//                    .background(Blurview())
//                    .cornerRadius(6)
//            }
//            .frame(maxHeight: 180)
            
            ZStack {

                HStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                    Spacer()
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)


                }.padding(10)
                .padding(.top, 1)

                SwiftUISlider(minTrackColor: UIColor.white, maxTrackColor: UIColor.white, value: self.$lidarViewModel.valueDouble)
                    .padding(10)
            }

            .frame(height: 60)
            .frame(width: 150)
            .background(Blurview())
            .cornerRadius(6)
            .rotationEffect(Angle(degrees: -90))
//            .padding(.bottom, 36)
            Spacer(minLength: 36)
//            if self.orientationInfo.orientation == .portrait {
//                Spacer()
//            }
            Spacer()
        }.frame(width: 60)
        
        .padding(.vertical, 36)
        .padding(.trailing, 36)
        
    }
    
    
    
}

