//
//  GameScene.swift
//  Marble Tilt
//
//  Created by Nikolas Beltran on 4/25/17.
//  Copyright © 2017 Nikolas Beltran. All rights reserved.
//

import SpriteKit
// Imports tilt functionality.
import CoreMotion


class GameScene: SKScene, SKPhysicsContactDelegate
{
//    let MarbleCategory:UInt32 = 0x1 << 0
//    let PickupCategory:UInt32 = 0x1 << 1
    
//    var player:SKSpriteNode!
//    var pickup1:SKSpriteNode!
    var count = 0
    
    var timerText:SKLabelNode!
    var gameOverText:SKLabelNode!
    var congratsText:SKLabelNode!
    var yourTimeText:SKLabelNode!
    
    var time = 0
    var timer = Timer()
    
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView)
    {
        self.physicsWorld.contactDelegate = self
        
//        player = self.childNode(withName: "marble") as? SKSpriteNode
//        pickup1 = self.childNode(withName: "pickup1") as? SKSpriteNode
        timerText = self.childNode(withName: "timerText") as? SKLabelNode
        gameOverText = self.childNode(withName: "gameOverText") as? SKLabelNode
        congratsText = self.childNode(withName: "congratsText") as? SKLabelNode
        yourTimeText = self.childNode(withName: "yourTimeText") as? SKLabelNode
        timerText.fontName = "Menlo-Bold"
        timerText.fontColor = UIColor.yellow
        gameOverText.fontName = "Menlo-Bold"
        gameOverText.fontColor = UIColor.lightGray
        congratsText.fontName = "Menlo-Bold"
        congratsText.fontColor = UIColor.white
        yourTimeText.fontName = "Menlo-Bold"
        yourTimeText.fontColor = UIColor.white
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.makeTime), userInfo: nil, repeats: true)
        
        // Starts updating the acceleromoter immediately.
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.main)
        {
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat(-(data?.acceleration.y)!) * 15, dy: CGFloat((data?.acceleration.x)!) * 15)
        }
    }
    
    func makeTime()
    {
        time += 1
        timerText.text = String(time)
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "marble"
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.node?.name == "marble" && secondBody.node?.name == "pickup"
        {
            secondBody.node?.removeFromParent()
            count += 1
            if (count == 12)
            {
                firstBody.node?.physicsBody?.isDynamic = false
                timer.invalidate()
                congratsText.text = "Congratulations!"
                yourTimeText.text = "Your Time Is"
                timerText.zPosition = 5
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute:
                {
                    if let scene = MenuScene(fileNamed: "MenuScene")
                    {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        self.view!.presentScene(scene, transition:SKTransition.crossFade(withDuration: 0.5))
                    }
                })
            }
        }
        if firstBody.node?.name == "marble" && secondBody.node?.name == "hazard"
        {
            firstBody.node?.physicsBody?.isDynamic = false
            timer.invalidate()
            gameOverText.text = "Game Over"
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:
                {
                    if let scene = MenuScene(fileNamed: "MenuScene")
                    {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        self.view!.presentScene(scene, transition:SKTransition.crossFade(withDuration: 0.5))
                    }
            })
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
