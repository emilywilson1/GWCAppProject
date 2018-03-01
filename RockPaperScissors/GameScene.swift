//
//  GameScene.swift
//  RockPaperScissors
//
//  Created by Emily Wilson on 2/28/18.
//  Copyright © 2018 Emily Wilson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var playAgain = SKLabelNode(text: "Play Again?")
    private var youWon = SKLabelNode(text: "You Won!")
    private var youLost = SKLabelNode(text: "You Lost!")
    
    private var rockNode : SKSpriteNode?
    private var paperNode : SKSpriteNode?
    private var scissorsNode : SKSpriteNode?
    
    private var choices = ["Rock", "Paper", "Scissors"]
    
    private var gameState : Int?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//instrLabel") as? SKLabelNode
        
        self.rockNode = self.childNode(withName: "//rockNode") as? SKSpriteNode
        self.paperNode = self.childNode(withName: "//paperNode") as? SKSpriteNode
        self.scissorsNode = self.childNode(withName: "//scissorsNode") as? SKSpriteNode
        
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        youWon.position = CGPoint(x: 0, y: (label?.position.y)! - 150)
        youLost.position = CGPoint(x: 0, y: (label?.position.y)! - 150)
        youWon.fontSize = 84
        youLost.fontSize = 84
        
        playAgain.fontSize = 96
        playAgain.position = CGPoint(x: 0, y: -50)
        gameState = 1
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    // only touch function that matters
    func touchUp(atPoint pos : CGPoint) {
        if (gameState == 1) {
            var userChose: Int;
            if (self.scissorsNode != nil && self.rockNode != nil && self.paperNode != nil) {
                if (pos.x > (self.rockNode?.position.x)! - (self.rockNode?.size.width)! / 2
                    && pos.x < (self.rockNode?.position.x)! + (self.rockNode?.size.width)! / 2) {
                    userChose = 0
                } else if (pos.x > (self.paperNode?.position.x)! - (self.paperNode?.size.width)! / 2
                    && pos.x < (self.paperNode?.position.x)! + (self.paperNode?.size.width)! / 2) {
                    userChose = 1
                } else if (pos.x > (self.scissorsNode?.position.x)! - (self.scissorsNode?.size.width)! / 2
                    && pos.x < (self.scissorsNode?.position.x)! + (self.scissorsNode?.size.width)! / 2) {
                    userChose = 2
                } else {
                    return
                }
                let gameChose = randomThing()
                print(gameChose, userChose)
                if (gameChose != userChose) {
                    if (userChose == 0) {
                        if (gameChose == 1) {
                           losingScreen(view: self.view!, userChoice: userChose, gameChoice: gameChose)
                        } else {
                            winningScreen(view: self.view!, userChoice: userChose, gameChoice: gameChose)
                        }
                    } else if (userChose == 1) {
                        if (gameChose == 0) {
                            winningScreen(view: self.view!, userChoice: userChose, gameChoice: gameChose)
                        } else {
                            losingScreen(view: self.view!, userChoice: userChose, gameChoice: gameChose)
                        }
                    } else {
                        if (gameChose == 1) {
                            winningScreen(view: self.view!, userChoice: userChose, gameChoice: gameChose)
                        } else {
                            losingScreen(view: self.view!, userChoice: userChose, gameChoice: gameChose)
                        }
                    }
                }
            }
        } else {
            if (pos.x > 0 - playAgain.frame.size.width / 2 && pos.x < 0 + playAgain.frame.size.width / 2) {
                setupPlayAgain()
            }
        }
    }
    
    func setupPlayAgain() {
        self.removeChildren(in: [playAgain, youWon, youLost])
        self.rockNode?.alpha = 1
        self.paperNode?.alpha = 1
        self.scissorsNode?.alpha = 1
        self.label?.text = "Choose One!"
        self.label?.fontSize = 96
        gameState = 1
    }
    
    func clearView(view: SKView) {
        rockNode?.alpha = 0
        paperNode?.alpha = 0
        scissorsNode?.alpha = 0
    }
    
    func randomThing() -> Int {
        return Int(arc4random_uniform(3));
    }
    
    func winningScreen(view: SKView, userChoice: Int, gameChoice: Int) {
        clearView(view: self.view!)
        let textString = choices[userChoice] + " beats " + choices[gameChoice] + "!"
        self.label?.text = textString;
        self.label?.fontSize = 84
        gameState = 0
        self.addChild(playAgain)
        self.addChild(youWon)
    }
    
    func losingScreen(view: SKView, userChoice: Int, gameChoice: Int) {
        clearView(view: self.view!)
        let textString = choices[gameChoice] + " beats " + choices[userChoice] + "!"
        self.label?.text = textString;
        self.label?.fontSize = 84
        gameState = 0
        self.addChild(playAgain)
        self.addChild(youLost)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
