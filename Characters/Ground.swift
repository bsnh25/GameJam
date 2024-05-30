//
//  Ground.swift
//  GameJam
//
//  Created by Khairul Rizki on 30/05/24.
//

import SpriteKit

class Ground: SKSpriteNode{
    init(){
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "Ground"
        zPosition = -1.0
        anchorPoint = CGPoint(x: 0.0, y:0.5)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration

extension Ground   {
    func setupGround(_ scene: SKScene){
        for i in 0...2{
            let ground = Ground()
            ground.position = CGPoint(x: CGFloat(i)*ground.frame.size.width, y: scene.frame.size.height/2.0)
            scene.addChild(ground)
        }
    }
    func moveGround(_ scene: GameScene){
        scene.enumerateChildNodes(withName: "Ground"){
            (node, _) in let node = node as! SKSpriteNode
            node.position.x -= scene.moveSpeed
        }
    }
}
