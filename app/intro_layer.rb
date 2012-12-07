class IntroLayer < CCLayer
  def self.scene
    scene = CCScene.node
    layer = IntroLayer.node
    scene.addChild layer
    scene
  end
  
  def init
    super
    size = CCDirector.sharedDirector.winSize
    if BW::Device.iphone?
      background = CCSprite.spriteWithFile("Default.png")
      background.rotation = 90
    else
      background = CCSprite.spriteWithFile("Default-Landscape~ipad.png")
    end
    background.position = [size.width/2, size.height/2]
    
    self.addChild background
    
    self
  end
  
  def onEnter
    super
    CCDirector.sharedDirector.replaceScene(CCTransitionFade.transitionWithDuration(1.0, scene:HelloWorldLayer.scene))
  end    
end