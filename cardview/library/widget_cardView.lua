-----------------------------------------------------------------------------------------
--
-- NewCradView widget
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require( "widget" )

function widget.newCardView( options )
    local customOptions = options or {}
    local opt = {}

    local default_width, default_height
    default_width = display.contentWidth
    default_height = 75
    opt.width = customOptions.width or default_width
    opt.height = customOptions.height or default_height

    local paint = {
        type = "gradient",
        color1 = { 0, 0, 0, 0 },
        color2 = { 0, 0, 0, 0.2 },
    }
	
	local container = display.newContainer( opt.width, opt.height )
	local rectangle1 = display.newRect(display.contentCenterX,display.contentCenterY,opt.width,opt.height)
	local myImage = display.newImage( customOptions.image )
	local title = display.newText( customOptions.title, 100, 200, container.width * 0.9, 20, native.systemFontBold, 18 )
	local description = display.newText(string.sub( customOptions.description, 1, 130).." ..." , 100, 200, container.width * 0.9, 150, native.systemFont, 18 )
	
	local function onEventTap() 
		print("tap")
		-- Free memory
		container:removeSelf()
		myImage:removeSelf()
		rectangle1:removeSelf()
		title:removeSelf()
		-- Redirict
		composer.gotoScene( customOptions.tap )
	end
	 
	container.x = customOptions.x
	container.y = customOptions.y
	container:addEventListener( "tap", onEventTap );
	rectangle1:setFillColor(customOptions.fillColor[1], customOptions.fillColor[2], customOptions.fillColor[3])
	rectangle1.stroke = paint
	rectangle1.strokeWidth = 8
	myImage.width = opt.width
	myImage.height = 150
	myImage.x = container.contentCenterX
	title:setFillColor(customOptions.textColor[1], customOptions.textColor[2], customOptions.textColor[3] , customOptions.textColor[4])
	title.anchorY = myImage.contentHeight
	title.y = 0
	description:setFillColor(customOptions.textColor[1], customOptions.textColor[2], customOptions.textColor[3] , customOptions.textColor[4])
	description.y = 0
	
	container:insert( rectangle1, true ) 
	container:insert( myImage, true )
	container:insert( title, true )
	container:insert( description, true )
	
	myImage.y = -75
	title.y = title.anchorY + 30
	title.width = container.width * 0.90
	description.x =  myImage.screenOriginX
	description.y =  ( myImage.contentHeight / 1.3 )  + 5
	
	return container
end