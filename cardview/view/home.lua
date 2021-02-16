-----------------------------------------------------------------------------------------
--
-- about us.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local widget = require( "widget" )
local composer = require( "composer" )
require( "library.widget_cardView" )
local scene = composer.newScene()
require ("library.corona_toast")

function scene:create( event )
	
    local sceneGroup = self.view
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local tabBarHeight = composer.getVariable( "tabBarHeight" )
    local backgroundColor = {  0.95  }

    local function scrollListener( event )
 
        local phase = event.phase
        if ( phase == "began" ) then print( "Scroll view was touched" )
        elseif ( phase == "moved" ) then print( "Scroll view was moved" )
        elseif ( phase == "ended" ) then print( "Scroll view was released" )
        end
     
        -- In the event a scroll limit is reached...
        if ( event.limitReached ) then
            if ( event.direction == "up" ) then print( "Reached bottom limit" )
            elseif ( event.direction == "down" ) then print( "Reached top limit" )
            elseif ( event.direction == "left" ) then print( "Reached right limit" )
            elseif ( event.direction == "right" ) then print( "Reached left limit" )
            end
        end
     
        return true
    end
     
    -- Create the widget
    local scrollView = widget.newScrollView(
        {
            left = 0,
            top = display.screenOriginY + 56,
            width = display.contentWidth,
            height = display.contentHeight - 60 - 56,
            hideBackground = false,
            backgroundColor = backgroundColor,
            --isBounceEnabled = false,
            horizontalScrollDisabled = true,
            verticalScrollDisabled = false,
            listener = scrollListener
        }
    ) 

    scrollView.y = display.contentCenterY

    sceneGroup:insert( scrollView )
	
	local panel1 = widget.newCardView({
		width = display.contentWidth * 0.9,
		x = display.contentCenterX,
		y = 170,
		height = 300,
		fillColor = { 1, 1, 1, 0.8 },
		textColor = { 0, 0, 0, 0.8 },
		tap = "view.authentification",
		image = "assets/wallpaper.png",
		title = "Mon titre pour la cardView1",
		description = "Removes the display object and frees its memory, assuming there are no other references to it. This is equivalent to calling group:remove() on the same display object, but it is syntactically simpler"
	})
    
	local panel2 = widget.newCardView({
		width = display.contentWidth * 0.9,
		x = display.contentCenterX,
		y = 500,
		height = 300,
		fillColor = { 1, 1, 1, 0.8 },
		textColor = { 0, 0, 0, 0.7 },
		tap = "view.authentification",
		image = "assets/wallpaper1.png",
		title = "Mon titre pour la cardView2",
		description = "Removes the display object and frees its memory, assuming there are no other references to it. This is equivalent to calling group:remove() on the same display object, but it is syntactically simpler"
	})

	
    scrollView:insert( panel1 )
	scrollView:insert( panel2 )

end

scene:addEventListener( "create" )

return scene