class HelloWorldLayer < CCLayer
  def self.scene
    scene = CCScene.node
    layer = HelloWorldLayer.node
    scene.addChild layer
    scene
  end
  
  def init
    super
    label = CCLabelTTF.labelWithString("Hello World", fontName:"Marker Felt", fontSize:64)
    size = CCDirector.sharedDirector.winSize
    label.position = [size.width/2,size.height/2]
    self.addChild label
    
    CCMenuItemFont.setFontSize 28
    itemAchievement = CCMenuItemFont.itemWithString("Achievements", block: lambda {|sender|
      achievementViewController = GKAchievementViewController.alloc.init
      achievementViewController.achievementDelegate = self
      
      app = UIApplication.sharedApplication.delegate
      app.navController.presentModalViewController(achievementViewController, animated:true)
    })
    
    itemLeaderboard = CCMenuItemFont.itemWithString("Leaderboard", block: lambda {|sender|
      leaderboardViewController = GKLeaderboardViewController.alloc.init
      leaderboardViewController.leaderboardDelegate = self
      
      app = UIApplication.sharedApplication.delegate
      app.navController.presentModalViewController(leaderboardViewController, animated:true)
    })
    
    menu = CCMenu.menuWithArray [itemAchievement, itemLeaderboard]
    menu.alignItemsHorizontallyWithPadding 20
    menu.setPosition [size.width/2, size.height/2 - 50]
    
    self.addChild menu
    self
  end
  
  def achievementViewControllerDidFinish(viewController)
    UIApplication.sharedApplication.delegate.navController.dismissModalViewControllerAnimated(true)
  end
  
  def leaderboardViewControllerDidFinish(viewController)
    UIApplication.sharedApplication.delegate.navController.dismissModalViewControllerAnimated(true)
  end
  
end


