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
        
    
        //Periodically Spawn Obstacles
        let actionWait = SKAction.wait(forDuration: 2)
        let actionSpawn = SKAction.run() { [weak self] in self?.spawnObstacle() }
        let actionSequence = SKAction.sequence([actionWait, actionSpawn])
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)
        run(actionObstacleRepeat)
    }
    
    func spawnObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "target")
        
        let verticalPosition = CGFloat(arc4random_uniform(UInt32(size.height - 350))) + 350
        let horizontalPosition = size.width + obstacle.size.width
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)
        
        obstacle.position = startingPosition
        
        addChild(obstacle)
        
        let endingPosition = CGPoint(x: -100, y: verticalPosition )
        let actionMove = SKAction.move(to: endingPosition, duration: 6)
        
        
        let actionRemove = SKAction.removeFromParent()
        
        let actionSequence = SKAction.sequence([actionMove, actionRemove])
        
        
        obstacle.run(actionSequence)
        obstacle.setScale(0.2)
        
        }
        //method responds to a single touch
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
            // when we touch a device are fingers are big
            guard let touch = touches.first else {
                return
            }
            //Print the location of the first touch
            let touchLocation = touch.location(in: self)
            
           //print the location of the touch in the console
            print(touchLocation.x)
            print(touchLocation.y)
            
            //let monkey move horizontally towards the touc.
            let destination = CGPoint (x: touchLocation.x, y: monkey.position.y)
            
            //create action 
            let actionMove = SKAction.move(to: destination, duration: 5)
            
            // tell the monkey sprite to move
            monkey.run(actionMove)
            
            shootProjectile()
        }

        func shootProjectile() {
    
            //creating an instance
            let projectile = SKSpriteNode(imageNamed: "fruit")
    
            // define starting positon
        let startingPosition =  CGPoint (x: monkey.position.x, y: monkey.position.y)
        projectile.position = startingPosition
        projectile.setScale(0.3)
        projectile.zPosition = 3
        
        
        //add the obstacle to the scene
        addChild(projectile)
            
        //Move the banana
        let endingPosition = CGPoint(x: monkey.position.x, y: 2000)
        let projectileMove = SKAction.move(to: endingPosition, duration: 2)
        
        let actionRemove = SKAction.removeFromParent() //This will remove the banana from the scene graph of the game
            
        // this defines the sequence of what should happen for this node
        let actionSequence = SKAction.sequence([projectileMove, actionRemove])
        
            
        
        //now instead of running a single action we run the sequence.
        projectile.run(actionSequence)
        }
       
    

}





