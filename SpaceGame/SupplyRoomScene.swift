//
//  SupplyRoomScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/28/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit
import CoreData


class SupplyRoomScene: SKScene {
    
    
    //var shipsShopIndex = NSMutableArray()
    //var PlayerShipDataItems = [PlayerShipData]()
    let playerData:PlayerData = GameViewController.memoryCard.playerData!
    override init() {
        Control.locations = NSMutableArray()
        super.init(size: Config.sceneSize())
    }
    


    
    var pagina = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.backgroundColor = GameColors.gray
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.addChild(Button(name: "buttonBack", x:28, y:657, xAlign:.left, yAlign:.down))
        
        self.addChild(Control(name: "SupplyBackground", x: 0, y: 0, align:.center))
        
        self.addChild(Button(name: "buttonLeftShips", textureName: "buttonLeft", x: 203, y: 547, align:.center))
        self.addChild(Button(name: "buttonRightShips", textureName: "buttonRight", x: 1053, y: 547, align:.center))
        
        
        
   
        
        //let playerShip = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 670, y: 192, loadPhysics:false)
        let playerShip = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 670, y: 192, loadPhysics: false)
        self.addChild(playerShip)
        
        let playerShip0 = PlayerShip(index:(4*pagina+0), x: 385, y: 570)
        playerShip0.name = "playerShip0"
        self.addChild(playerShip0)
        
        let playerShip1 = PlayerShip(index:(4*pagina+1), x: 570, y: 570)
        playerShip1.name = "playerShip1"
        self.addChild(playerShip1)
        
        let playerShip2 = PlayerShip(index:(4*pagina+2), x: 765, y: 570)
        playerShip2.name = "playerShip2"
        self.addChild(playerShip2)
        
        let playerShip3 = PlayerShip(index:(4*pagina+3), x: 950, y: 570)
        playerShip3.name = "playerShip3"
        self.addChild(playerShip3)
        
        

        
        self.addChild(Label(name:"labelPreco0", textureName:"0", x:380, y:660, align:.center))
        self.addChild(Label(name:"labelPreco1", textureName:"0", x:570, y:660, align:.center))
        self.addChild(Label(name:"labelPreco2", textureName:"0", x:760, y:660, align:.center))
        self.addChild(Label(name:"labelPreco3", textureName:"0", x:950, y:660, align:.center))
        
        
        

        
        self.addChild(Label(name:"labelScore", textureName:"$0", x:267, y:39, align:.center))
        
        self.updateControls()
        
        
    }
    
    func updateControls() {
        
       let playerShip = self.childNodeWithName("player") as! PlayerShip

         
        (self.childNodeWithName("playerShip0") as! PlayerShip).reloadNewShip(4*pagina+0)
        (self.childNodeWithName("playerShip1") as! PlayerShip).reloadNewShip(4*pagina+1)
        (self.childNodeWithName("playerShip2") as! PlayerShip).reloadNewShip(4*pagina+2)
        (self.childNodeWithName("playerShip3") as! PlayerShip).reloadNewShip(4*pagina+3)
        
        
        let playerShip0 = PlayerShip(index:(4*pagina+0), x: 385, y: 570)
        let playerShip1 = PlayerShip(index:(4*pagina+1), x: 570, y: 570)
        let playerShip2 = PlayerShip(index:(4*pagina+2), x: 765, y: 570)
        let playerShip3 = PlayerShip(index:(4*pagina+3), x: 950, y: 570)
        
        let playerType0 = Ships.types[playerShip0.type] as! ShipType
        let playerType1 = Ships.types[playerShip1.type] as! ShipType
        let playerType2 = Ships.types[playerShip2.type] as! ShipType
        let playerType3 = Ships.types[playerShip3.type] as! ShipType
        
        
        
        
        
        (self.childNodeWithName("labelScore") as! Label).setText("$" + self.playerData.score.description)
        (self.childNodeWithName("labelPreco0") as! Label).setText(self.price(0).priceDescription, color:self.price(0).priceColor)
        (self.childNodeWithName("labelPreco1") as! Label).setText(self.price(1).priceDescription, color:self.price(1).priceColor)
        (self.childNodeWithName("labelPreco2") as! Label).setText(self.price(2).priceDescription, color:self.price(2).priceColor)
        (self.childNodeWithName("labelPreco3") as! Label).setText(self.price(3).priceDescription, color:self.price(3).priceColor)
        
        (self.childNodeWithName("buttonRightShips") as! Button).hidden = pagina == 2
        (self.childNodeWithName("buttonLeftShips") as! Button).hidden = pagina == 0
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesBegan(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                self.view?.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
                return
            }
            
            if (self.childNodeWithName("buttonLeftShips")!.containsPoint(location)) {
                    if (pagina > 0)
                    {
                        pagina--
                        self.updateControls()
                        return
                    }
            }
            
            if (self.childNodeWithName("buttonRightShips")!.containsPoint(location)) {
                    if (pagina < 2)
                    {
                        pagina++
                        self.updateControls()
                        return
                    }
            }
            
            let playerShip = self.childNodeWithName("player") as! PlayerShip
            
            if (self.childNodeWithName("playerShip0")!.containsPoint(location)) {
                
                var aux = 0
                
                for ship in self.playerData.playerShips {
                    if ((ship as! PlayerShipData).shopIndex == 4*pagina+0)
                    {
                        
                       
                        playerShip.reloadNewShip(4*pagina+0)
                        self.playerData.currentPlayerShip = ship as! PlayerShipData
                        aux = 1
                        break
                    }
                }
                
                if (aux == 0)
                {
                    
                    let playerType = Ships.types[4*pagina+0] as! ShipType
                    
                    
                     if(Int(self.playerData.score) >= playerType.price)
                    {
                        
                        self.buyShip(0)
                    }
                 
                    
                    
                }

                
                
                    self.updateControls()
                
                    return
                
            }
            
            if (self.childNodeWithName("playerShip1")!.containsPoint(location)) {
                
                var aux = 0
                
                for ship in self.playerData.playerShips {
                    if ((ship as! PlayerShipData).shopIndex == 4*pagina+1)
                    {
                        
                      
                        playerShip.reloadNewShip(4*pagina+1)
                        self.playerData.currentPlayerShip = ship as! PlayerShipData
                        aux = 1
                        break
                    }
                }
                
                if (aux == 0)
                {
                    
                    let playerType = Ships.types[4*pagina+1] as! ShipType
                    
                    
                    if(Int(self.playerData.score) >= playerType.price)
                    {
                    
                        self.buyShip(1)
                    }
                 
                    
                    
                }

                self.updateControls()
                
                return
                
            }
            
            if (self.childNodeWithName("playerShip2")!.containsPoint(location)) {
                
                var aux = 0
                
                for ship in self.playerData.playerShips {
                    if ((ship as! PlayerShipData).shopIndex == 4*pagina+2)
                    {
                        
                      
                        playerShip.reloadNewShip(4*pagina+2)
                        self.playerData.currentPlayerShip = ship as! PlayerShipData
                        aux = 1
                        break
                    }
                }
                
                if (aux == 0)
                {
                    
                    let playerType = Ships.types[4*pagina+2] as! ShipType
                    
                    
                    if(Int(self.playerData.score) >= playerType.price)
                    {
                  
                        self.buyShip(2)
                    }
                
                    
                    
                }
                self.updateControls()
                
                return
                
            }
            
            
            if (self.childNodeWithName("playerShip3")!.containsPoint(location)) {
                
                var aux = 0
                
                for ship in self.playerData.playerShips {
                    if ((ship as! PlayerShipData).shopIndex == 4*pagina+3)
                    {
                        
                        
                        playerShip.reloadNewShip(4*pagina+3)
                        self.playerData.currentPlayerShip = ship as! PlayerShipData
                        aux = 1
                        break
                    }
                }
                
                if (aux == 0)
                {
                    
                    let playerType = Ships.types[4*pagina+3] as! ShipType
                    
                    
                    if(Int(self.playerData.score) >= playerType.price)
                    {
                        
                        self.buyShip(3)
                    }
                   
                    
                    
                }
                self.updateControls()
                
                return
                
            }

            
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
    
    
    func buyShip(indexTouch: Int)
        
    {
        
        // Busca a nave instanciada na tela e atualiza sua imagem
        let playerShip = self.childNodeWithName("player") as! PlayerShip
        playerShip.reloadNewShip(4*pagina+indexTouch)
        
        
        // Busca o preco pelo tipo da nave e subtrai do dinheiro do jogador
        let playerType = Ships.types[4*pagina+indexTouch] as! ShipType
        self.playerData.score = Int(self.playerData.score) - playerType.price
        
        
        // Cria uma nova instancia do objeto a ser inserido no core data
        var playerShipData = NSEntityDescription.insertNewObjectForEntityForName("PlayerShipData", inManagedObjectContext: GameViewController.memoryCard.managedObjectContext!) as! PlayerShipData
        
        
        // Define os atributos do objeto a ser inserido
        playerShipData.shopIndex = 4*pagina+indexTouch
        playerShipData.level = 1// nova nave inicia level 1
        
        
        // Insere o objeto no core data atraves da extension na classe playerData
        self.playerData.addPlayerShipObject(playerShipData)
        
       
        // Define a nave comprada como a atual
        self.playerData.currentPlayerShip = playerShipData
        
    }
    
    func price(indexPrice: Int) -> (priceDescription: String, priceColor: UIColor)
    {
        var aux = 0
        
        for ship in self.playerData.playerShips {
            if ((ship as! PlayerShipData).shopIndex == 4*pagina+indexPrice)
            {
                
                aux = 1
                return ("Purchased", GameColors.white )
                
            }
        }
        
        if (aux == 0)
        {
           
            

            
            let playerType = Ships.types[4*pagina+indexPrice] as! ShipType
            
            let color:UIColor!
            if(Int(self.playerData.score) >= playerType.price){
                color = GameColors.green
            } else {
                color = GameColors.red
            }
            
           return (("$"+playerType.price.description), color)
        }
    }
    
    
}
