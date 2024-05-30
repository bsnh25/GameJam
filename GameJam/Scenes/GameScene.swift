//
//  GameScene.swift
//  GameJam
//
//  Created by Bayu Septyan Nur Hidayat on 29/05/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // ini physic (2)
        setupPhysics()
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }

    
    
    //Movement
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//       super.touchesBegan(touches, with: event)
//        playerNode.setupMoveUpDown()
//    }
    
}


extension GameScene {
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
        //        wall.position = CGPoint(x: size.width + wall.frame.width, y: frame.height/2.0 + (wall.frame.height + groundNode.frame.height)/2.0 * scale)
        
        //Add physic (1)
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        addChild(wall)
        wall.run(.sequence([.wait(forDuration: 8.0), .removeFromParent()]))
        
        
        
        
    }
    
    @objc func setupPhysics(){
        physicsWorld.contactDelegate = self
    }
    
    // Step 4
//    func gameOver(){
////        playerNode.removeFromParent()
//    }
}

// Step 3
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
        
        switch other.categoryBitMask{
        case PhysicsCategory.Wall:
            printContent("wall")
        default: break
        }
    }
}
