//
//  InstructionsScene.swift
//  Marble Tilt
//
//  Created by Nikolas Beltran on 5/20/17.
//  Copyright © 2017 Nikolas Beltran. All rights reserved.
//

import SpriteKit

class InstructionsScene: SKScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "CloseButton"
            {
                if let scene = MenuScene(fileNamed: "MenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition:SKTransition.crossFade(withDuration: 0.5))
                }
            }
        }
    }

}
