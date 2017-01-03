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
    
    // label and variable to track score
    
    let scoreLabel = SKLabelNode(fontNamed: "Helvitica-Bold")
    var score = 0 // This tracks the current score
    
    //This function runs once at the start of the game
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
        
        // add the heads up display to show the score
        scoreLabel.text = String(score)
        scoreLabel.fontColor = SKColor.white
        scoreLabel.fontSize = 96
        scoreLabel.zPosition = 150 // Make sure this Heads up Display is on top of all the other nodes in the scene
        scoreLabel.position = CGPoint(x: size.width - size.width / 2 , y: size.height - size.height / 1)
        addChild(scoreLabel)
        
    }
    
    // This method runs about 60 times per second (60 fps)
    override func update(_ currentTime: TimeInterval) {
        
        // check for collisions between the bananas and the targets
        checkAllBananas()
    }
    
    //find all bananas currently on the screen
    
    func checkAllBananas() {
        
    // find all bananas currently in flight. 
        enumerateChildNodes(withName: "banana", using: {
                node, _ in
            
    // get a reference to the current banana
            let banana = node as! SKSpriteNode
            
    // using this single  banana, check  for collisions against all targets on screen currently. 
            
            self.lookForTargetsHitBy(banana)
            
        })
        
    }
    
    // Check for Collisions between a given target and a banana
    func lookForTargetsHitBy(_ banana : SKSpriteNode) {
    
    //find all targets currently in flight
    enumerateChildNodes(withName: "target", using: {
        node, _ in
            
    //get a reference to the current target
    
        let target =  node as! SKSpriteNode
    
    //determine wether this target is being hit by a banana
    
        if target.frame.insetBy(dx: 20, dy:
            20).intersects(banana.frame.insetBy(dx: 20, dy: 20)) {
            
    //increase the score variable
    
    score += 1
    
    //update the score label 
            
    scoreLabel.text = String(score)
            
    // There is a collision so remove both nodes
    banana.removeFromParent()
    target.removeFromParent()
            
            }
        
        })
    }
        
        
        
    func spawnObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "target")
        obstacle.name = "target"
        
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
        
        //let monkey move horizontally towards the touch.
        let destination = CGPoint (x: touchLocation.x, y: monkey.position.y)
        
        //create action
        let actionMove = SKAction.move(to: destination, duration: 5)
        
        // tell the monkey sprite to move
        monkey.run(actionMove)
        
        shootProjectile()
    }
    
    func shootProjectile() {
        
        //creating an instance
        let projectile = SKSpriteNode(imageNamed: "banana")
        
        // define starting positon
        let startingPosition =  CGPoint (x: monkey.position.x, y: monkey.position.y)
        projectile.position = startingPosition
        projectile.setScale(0.1)
        projectile.name = "banana"
        projectile.zPosition = 3
        
        
        //add the projectile to the scene
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



