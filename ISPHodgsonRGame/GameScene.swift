//
//  GameScene.swift
//  ISPHodgsonRGame
//
//  Created by Ryan Hodgson on 2016-11-24.
//  Copyright © 2016 Ryan Hodgson. All rights reserved.
//

import SpriteKit

class GameScene : SKScene {
    
    let monkey = SKSpriteNode(imageNamed: "monkey")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "Jungle")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.frame.size
        addChild(background)
        background.size = self.frame.size
        
        monkey.position = CGPoint(x: double, y: Double))
        
    }
}


