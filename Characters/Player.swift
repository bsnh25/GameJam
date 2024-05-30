//
//  Player.swift
//  GameJam
//
//  Created by Bayu Septyan Nur Hidayat on 30/05/2024.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var isMoveDown = false
    
    init() {
        let texture = SKTexture(imageNamed: "player1")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "Player"
        zPosition = 1.0
        setScale(1.5)
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.Wall
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configurations

extension Player {
    
    func setupPlayer(_ ground: Ground, scene: SKScene) {
        position = CGPoint(x: scene.frame.width/2.0 - 100.0, y: (scene.frame.height + ground.frame.height + frame.height)/2.0)
        scene.addChild(self)
        setupAnim()
    }
    
    func setupAnim() {
        var textures: [SKTexture] = []
        
        for i in 1...2 {
            textures.append(SKTexture(imageNamed: "player\(i)"))
        }
        
        run(.repeatForever(.animate(with: textures, timePerFrame: 0.10)))
    }
    
    func setupMoveUpDown() {
        isMoveDown = !isMoveDown
        let scale: CGFloat
        let position: CGFloat
//        let moveBy: SKAction
        
        if isMoveDown {
            scale = -1.5
            position = -0.475
            
        } else {
            scale = 1.5
            position = 0.475
        }
        
        let flipY = SKAction.scaleY(to: scale, duration: 0.1)
        run(flipY)
        
        let moveBy = SKAction.moveBy(x: 0.0, y: position*(frame.width*2.6), duration: 0.1)
        run(moveBy)
        
//        if isMoveDown {
//            scale = 0.5  // Adjusted scale value for moving down
//            moveBy = SKAction.moveBy(x: 0.0, y: -frame.height / 2, duration: 0.1)
//        } else {
//            scale = 1.0  // Adjusted scale value for moving up
//            moveBy = SKAction.moveBy(x: 0.0, y: frame.height / 2, duration: 0.1)
//        }
//
//        let flipY = SKAction.scaleY(to: scale, duration: 0.1)
//        let checkPosition = SKAction.run {
//            // Ensure player doesn't move out of the visible area
//            if self.position.y < self.size.height / 2 {
//                self.position.y = self.size.height / 2
//            } else if self.position.y > self.scene!.size.height - self.size.height / 2 {
//                self.position.y = self.scene!.size.height - self.size.height / 2
//            }
//        }
        
//        run(SKAction.sequence([flipY, moveBy, checkPosition]))
    }
}
