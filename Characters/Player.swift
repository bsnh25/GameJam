//
//  Player.swift
//  GameJam
//
//  Created by Bayu Septyan Nur Hidayat on 29/05/24.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var isMoveDown = false
    
    init(){
        let texture = SKTexture(imageNamed: "Tikus1")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "Player"
        zPosition = 1.0
        setScale(0.75)
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Wall
        physicsBody?.contactTestBitMask = PhysicsCategory.Score | PhysicsCategory.Score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not be implemented")
    }
}

//MARK - Configuration Movement

extension Player {
//    func setupPlayer(_ ground: Ground, scene: SKScene) {
//        position = CGPoint(x: scene.frame.width/2.0 - 100.0, y: (scene.frame.height + ground.frame.height + frame.height)/2.0)
//        scene.addChild(self)
//        setupAnim()
//    }
    
    
    func setupAnim(){
        var textures: [SKTexture] = []
        
        for i in 1...2 {
            textures.append(SKTexture(imageNamed: "Tikus\(i)"))
        }
        run(.repeatForever(.animate(with: textures, timePerFrame: 0.1)))
    }
    
    func setupMoveUpDown() {
        isMoveDown = !isMoveDown
        let scale: CGFloat
        
        if isMoveDown {
            scale = -0.75
        } else {
            scale = 0.75
        }
        
        let flipY = SKAction.scaleX(to: scale, duration: 0.1)
        run(flipY)
        
        let moveBy = SKAction.moveBy(x: 0.0, y: scale*(frame.width*2.6), duration: 0.1)
        run(moveBy)
    }
}
