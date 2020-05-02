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
    let scene = SCNScene()
    var scnView = SCNView()
    @State var text = ""
    
    init (text: Binding<String>) {
        self.text = text.wrappedValue
    }
    func makeUIView(context: Context) -> SCNView {
        
        if (scene.rootNode.childNodes.count > 0) {
            return scnView
        }
        
        // create a box
        scene.rootNode.addChildNode(createBox())

        // code for creating the camera and setting up lights is omitted for simplicity
        // …

        // retrieve the SCNView
        
        scnView.scene = scene
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // configure the view
        scnView.backgroundColor = UIColor.gray

        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        scnView.debugOptions = .showWireframe
    }

    func createBox() -> SCNNode {
        let boxGeometry = SCNBox(width: 20, height: 24, length: 40, chamferRadius: 0)
        let box = SCNNode(geometry: boxGeometry)
        box.name = "box"
        return box
    }

    func removeBox() {
        // check if box exists and remove it from the scene
        guard let box = scene.rootNode.childNode(withName: "box", recursively: true) else { return }
        box.removeFromParentNode()
    }

    func addBox() {
        // check if box is already present, no need to add one
        if scene.rootNode.childNode(withName: "box", recursively: true) != nil {
            return
        }
        scene.rootNode.addChildNode(createBox())
    }
}
