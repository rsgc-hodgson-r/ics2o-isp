//
//  GameScene.swift
//  ISPHodgsonRGame
//
//  Created by Ryan Hodgson on 2016-11-24.
//  Copyright © 2016 Ryan Hodgson. All rights reserved.
//

import SpriteKit

class GameScene : SKScene {
    
    let monkey = SKSpriteNode(imageNamed: "Monkey")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "Jungle")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        background.size = self.frame.size
        addChild(background)
        background.size = self.frame.size
        
        monkey.position = CGPoint(x: size.width / 2, y: 200)
        monkey.setScale(2.3)
        addChild(monkey)
      spawnObstacle()
    }
    
    func spawnObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "target")
        let startingPosition = CGPoint(x: 200, y: size.height)
        obstacle.position = startingPosition
        
        addChild(obstacle)
        
        let endingPosition = CGPoint(x: 0, y: 0)
        let actionMove = SKAction.move(to: endingPosition, duration: 5)
        obstacle.run(actionMove)
        
    }
}












    
    



