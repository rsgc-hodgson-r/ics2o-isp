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
        background.zPosition = -1
        addChild(background)
        background.size = self.frame.size
        
        monkey.position = CGPoint(x: size.width / 2, y: 200)
        monkey.setScale(3.3)
        addChild(monkey)
        let actionWait = SKAction.wait(forDuration: 2)
        let actionSpawn = SKAction.run() { [weak self] in self?.spawnObstacle() }
        let actionSequence = SKAction.sequence([actionWait, actionSpawn])
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)
        run(actionObstacleRepeat) 
    }
    
    func spawnObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "target")
        
        let verticalPosition = CGFloat(arc4random_uniform(UInt32(size.height)))
        let horizontalPosition = size.width + obstacle.size.width
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)
        
        obstacle.position = startingPosition
        
        addChild(obstacle)
        
        let endingPosition = CGPoint(x: -100, y: verticalPosition )
        let actionMove = SKAction.move(to: endingPosition, duration: 5)
        obstacle.run(actionMove)
        
        obstacle.setScale(0.2)
    }
}












    
    



