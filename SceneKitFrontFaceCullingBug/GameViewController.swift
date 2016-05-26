//
//  GameViewController.swift
//  SceneKitFrontFaceCullingBug
//
//  Created by Lachlan Hurst on 26/05/2016.
//  Copyright (c) 2016 Lachlan Hurst. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {

    var box:SCNGeometry!

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)

        

        let box = SCNBox(width: 1, height: 2, length: 3, chamferRadius: 0.2)
        box.firstMaterial!.cullMode = .Front
        let boxNode = SCNNode(geometry: box)
        boxNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
        scene.rootNode.addChildNode(boxNode)
        self.box = box

        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.lightGrayColor()
        scnView.autoenablesDefaultLighting = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)



        let overlayNode = SKShapeNode(rect: CGRectMake(10,10,200,200), cornerRadius: 4)
        overlayNode.position = CGPointMake(10, 10)
        overlayNode.fillColor = UIColor.redColor()
        overlayNode.strokeColor = UIColor.greenColor()
        overlayNode.lineWidth = 3.0

        let overlayScene = SKScene(size: self.view.frame.size)
        overlayScene.addChild(overlayNode)

        scnView.overlaySKScene = overlayScene

    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        if  box.firstMaterial!.cullMode == .Front {
            box.firstMaterial!.cullMode = .Back
        } else {
            box.firstMaterial!.cullMode = .Front
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
