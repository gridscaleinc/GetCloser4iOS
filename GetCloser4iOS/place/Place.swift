//
//  Place.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/04/25.
//  Copyright © 2020 gridscale. All rights reserved.
//

import SwiftUI
import SceneKit

struct Place: UIViewRepresentable {
    @State var message: String = "Hello World!"
    let scene = SCNScene()
    @State var count = 1
    
    func makeUIView(context: Context) -> SCNView {

        let scnView = SCNView()
        
        // code for creating the camera and setting up lights is omitted for simplicity
        // …

        // retrieve the SCNView
        
        scnView.scene = scene
        scnView.antialiasingMode = .multisampling4X
            
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // configure the view
        scnView.backgroundColor = UIColor.black

        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        

        addLightNode()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.count += 1
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "ja_JP")
            self.message = dateFormatter.string(from: Date())
            print(self.message)
        }
        
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        
        let scntext = SCNText(string: message, extrusionDepth: 3)
        scntext.flatness = 0.1
        scntext.chamferRadius = 0.2
        // テキストの色を設定する
        // SCNText には最大5つの要素があり、それぞれに SCNMaterial を指定できる
        let m1 = SCNMaterial()
        m1.diffuse.contents = UIColor.white
        
        // back material
        let m2 = SCNMaterial()
        m2.diffuse.contents = UIColor.lightGray

        scntext.materials = [m1, m2, m2]
        
        let textNode = SCNNode(geometry: scntext)
//        textNode.scale = SCNVector3(0.3,0.3,0.3)
        textNode.position = SCNVector3(Int.random(in: 100...200),Int.random(in: 100...200),Int.random(in: 100...200))
        let ac = SCNAction.move(by: SCNVector3(10, 10, -90), duration: 7)
        
        scene.rootNode.addChildNode(textNode)
        print("childNodes: \(scene.rootNode.childNodes.count)")
        
        textNode.runAction(ac, completionHandler: {
            textNode.removeFromParentNode()
        })
        
        
    }

    
    func addLightNode() {
        // Create ambient light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor(white: 0.70, alpha: 1.0)

        // Add ambient light to scene
        scene.rootNode.addChildNode(ambientLightNode)

        // Create directional light
        let directionalLight = SCNNode()
        directionalLight.light = SCNLight()
        directionalLight.light!.type = .directional
        directionalLight.light!.color = UIColor(white: 1.0, alpha: 1.0)
        directionalLight.eulerAngles = SCNVector3(x: 0, y: 0, z: 0)

        scene.rootNode.addChildNode(directionalLight)
    }
}
