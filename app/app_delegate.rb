class MyNavigationController < UINavigationController
  def supportedInterfaceOrientations
    if BW::Device.iphone?
      UIInterfaceOrientationMaskLandscape
    else
      UIInterfaceOrientationMaskLandscape
    end
  end
  
  def shouldAutorotateToInterfaceOrientation(orientation)
    [UIInterfaceOrientationLandscapeLeft, UIInterfaceOrientationLandscapeRight].include? orientation
  end
  
end

class AppDelegate
  attr_accessor :window, :nav_controller, :director
  alias_method :navController, :nav_controller
  alias_method :navController=, :nav_controller=
  
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    
    glView = CCGLView.viewWithFrame @window.bounds,
      pixelFormat: KEAGLColorFormatRGB565,
      depthFormat: 0,
      preserveBackbuffer: false,
      sharegroup: nil,
      multiSampling: false,
      numberOfSamples: 0

    @director = CCDirector.sharedDirector
    @director.wantsFullScreenLayout = true
    @director.displayStats = true
    @director.animationInterval = 1.0/60
    @director.view = glView
    @director.projection = KCCDirectorProjection2D
    @director.enableRetinaDisplay true

    @nav_controller = MyNavigationController.alloc.initWithRootViewController @director
    @nav_controller.navigationBarHidden = true
    @director.delegate = @nav_controller


    @window.setRootViewController @nav_controller
    @window.makeKeyAndVisible

    CCTexture2D.defaultAlphaPixelFormat = KCCTexture2DPixelFormat_RGBA8888

    file_utils = CCFileUtils.sharedFileUtils
    file_utils.enableFallbackSuffixes = false
    file_utils.setiPhoneRetinaDisplaySuffix "-hd"
    file_utils.setiPadSuffix "-ipad"
    file_utils.setiPadRetinaDisplaySuffix "-ipadhd"

    CCTexture2D.PVRImagesHavePremultipliedAlpha true

    @director.pushScene IntroLayer.scene
    true
  end

  def applicationWillResignActive(app)
    @director.pause if @nav_controller.visibleViewController == @director
  end

  def applicationDidBecomeActive(app)
    @director.resume if @nav_controller.visibleViewController == @director
  end

  def applicationDidEnterBackground(app)
    @director.stopAnimation if @nav_controller.visibleViewController == @director
  end

  def applicationWillEnterForeground(app)
    @director.startAnimation if @nav_controller.visibleViewController == @director
  end

  def applicationWillTerminate(app)
    @director.end
  end

  def applicationDidReceiveMemoryWarning(app)
    @director.purgeCachedData
  end

  def applicationSignificantTimeChange(app)
    @director.setNextDeltaTimeZero true
  end

end
