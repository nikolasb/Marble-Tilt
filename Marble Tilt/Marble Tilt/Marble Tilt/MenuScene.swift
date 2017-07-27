//
//  MenuScene.swift
//  Marble Tilt
//
//  Created by Nikolas Beltran on 5/19/17.
//  Copyright © 2017 Nikolas Beltran. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "StartButton"
            {
                if let scene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition:SKTransition.crossFade(withDuration: 0.5))
                }
            }
            if atPoint(location).name == "InstructionsButton"
            {
                if let scene = InstructionsScene(fileNamed: "InstructionsScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition:SKTransition.crossFade(withDuration: 0.5))
                }
            }
            if atPoint(location).name == "AboutButton"
            {
                if let scene = AboutScene(fileNamed: "AboutScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition:SKTransition.crossFade(withDuration: 0.5))
                }
            }
        }
    }
}
