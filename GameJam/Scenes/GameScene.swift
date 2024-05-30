//
//  GameScene.swift
//  NInja
//
//  Created by Jack Ily on 13/11/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Properties
    
    var groundNode = Ground()
    var playerNode = Player()
    var cloud = Cloud()
    
    var moveSpeed: CGFloat = 8.0
    
    var wallTimer: Timer?
    var cloudTimer: Timer?
    
  
    
    
    
    //MARK: - Systems
    
    override func didMove(to view: SKView) {
     
        
//        let shape = SKShapeNode(rect: playableRect)
//        shape.lineWidth = 4.0
//        shape.strokeColor = .red
//        addChild(shape)
    }
    

    override func update(_ currentTime: TimeInterval) {
 
        groundNode.moveGround(self)
        moveWall()
        cloud.moveCloud(self)
    }
}

//MARK: - Configurations

extension GameScene {
    
    func setupNodes() {
        groundNode.setupGround(self)
        playerNode.setupPlayer(groundNode, scene: self)
        cloud.setupClouds()
    }
    
    func setupPhysics() {
        physicsWorld.contactDelegate = self
    }
    
    
    @objc func spawnWalls() {
        let scale: CGFloat
        if Int(arc4random_uniform(UInt32(2))) == 0 {
            scale = -1.0
            
        } else {
            scale = 1.0
        }
        
        //Wall
        let wall = SKSpriteNode(imageNamed: "block").copy() as! SKSpriteNode
        wall.name = "Block"
        wall.zPosition = 2.0
        let value: CGFloat = wall.frame.height + groundNode.frame.height
        let wallPosY = frame.height/2.0 + (value/2.0 * scale)
        wall.position = CGPoint(x: size.width + wall.frame.width, y: wallPosY)
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody!.isDynamic = false
        wall.physicsBody!.categoryBitMask = PhysicsCategory.Wall
        addChild(wall)
        wall.run(.sequence([.wait(forDuration: 8.0), .removeFromParent()]))
        
        //Score
        let score = SKSpriteNode(texture: nil, color: .red, size: CGSize(width: 50.0, height: 50.0)).copy() as! SKSpriteNode
        score.name = "Score"
        score.zPosition = 5.0
        let scorePosY = frame.height/2.0 + (value/2.0 * (-scale))
        score.position = CGPoint(x: wall.position.x + score.frame.width, y: scorePosY)
        score.physicsBody = SKPhysicsBody(rectangleOf: score.size)
        score.physicsBody!.isDynamic = false
        score.physicsBody!.categoryBitMask = PhysicsCategory.Score
        addChild(score)
    }
    
    func moveWall() {
        enumerateChildNodes(withName: "Block") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= self.moveSpeed
        }
        
        enumerateChildNodes(withName: "Score") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= self.moveSpeed
        }
    }
    

    
    
}
