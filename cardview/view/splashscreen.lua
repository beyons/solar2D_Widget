-----------------------------------------------------------------------------------------
--
-- Splashscreen.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
local composer = require( "composer" )
require( "library.corona_network" )
local scene = composer.newScene()
--Create tab Bar
local function leaveScreen()
    myImage:removeSelf()
    composer.gotoScene( "view.authentification")
end

function scene:create( event )
    local sceneGroup = self.view
    local tabBarHeight = composer.getVariable( "tabBarHeight" )
    display.setDefault( "background", 0, 0, 0, 0 )
    -- hide status bar 
    display.setStatusBar(display.HiddenStatusBar);
    -- hide navigation bar
    native.setProperty("androidSystemUiVisibility", "immersiveSticky");
    -- Check connexion
    if isRechable() == true then 
        -- Network is Available Here. Do Something
        composer.setVariable("closure", 1);
      else 
        composer.setVariable("closure", 0);
        -- Network is Not Available Here.
        native.showAlert( "Se connecter à un réseau","Il semble qu'internet n'est pas disponible. Veuillez vous connecter à internet via WIFI ou 3G.", { "Continuer" } )
      end
    
    local imageSuffix = display.imageSuffix
    if(imageSuffix == nil) then
        imageSuffix = "@2x"
    end
    myImage = display.newImage( "assets/logo"..imageSuffix..".png", opiton )
    myImage.x = display.contentCenterX
    myImage.y = display.screenOriginY + ( myImage.height / 2 ) + 70
    

    local progressView = widget.newProgressView(
        {
            left = display.contentCenterX - 110,
            top = display.contentHeight - 100,
            width = 220,
            isAnimated = true
        }
    )
 
    -- Set the progress to 50%
    progressView:setProgress( 1 )
    timer.performWithDelay(1500, leaveScreen)
    sceneGroup:insert( myImage )
    sceneGroup:insert( progressView )
end

scene:addEventListener( "create" )

return scene