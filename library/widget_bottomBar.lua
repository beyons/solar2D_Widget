-----------------------------------------------------------------------------------------
--
-- NewButtonBar widget
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )

function widget.newButtonBar( options )
    local customOptions = options or {}
    local opt = {}

    local default_width, default_height
    default_width = display.contentWidth
    default_height = 75
    opt.width = customOptions.width or default_width
    opt.height = customOptions.height or default_height

    local paint = {
        type = "gradient",
        color1 = { 0, 0, 0, 1 },
        color2 = { 0, 0, 0, 0 },
    }

    local paint2 = {
        type = "gradient",
        color1 = { customOptions.btnBackground[1], customOptions.btnBackground[2], customOptions.btnBackground[3], 1 },
        color2 = { customOptions.btnBackground[1], customOptions.btnBackground[2], customOptions.btnBackground[3], 0 },
    }

    local myRectangle = display.newRect( display.contentCenterX, display.contentHeight - opt.height / 2, opt.width, opt.height )
    myRectangle.strokeWidth = 0
    myRectangle:setFillColor( customOptions.fillColor[1], customOptions.fillColor[2], customOptions.fillColor[3] )

    local myRoundedRect = display.newRoundedRect( display.contentCenterX, myRectangle.y - opt.height / 2, 60, 60, 30 )
    myRoundedRect:setFillColor( customOptions.fillColor2[1], customOptions.fillColor2[2], customOptions.fillColor2[3] )
    myRoundedRect.stroke = paint
    myRoundedRect.strokeWidth = 3 

    -- Rounded Button
    local myRoundedRect2 = display.newRoundedRect( display.contentCenterX, myRectangle.y - opt.height / 2, customOptions.btnWidth, customOptions.btnHeight, customOptions.btnWidth/2 )
    myRoundedRect2.strokeWidth = 3
    myRoundedRect2:setFillColor( customOptions.btnBackground[1], customOptions.btnBackground[2], customOptions.btnBackground[3] )
    myRoundedRect2.stroke = paint2
    
    local CenterBTN = widget.newButton({
        label = customOptions.centerLabel,
        onEvent = customOptions.onCenterBtnAction,
        emboss = false,
        shape = "roundedRect",
        width = customOptions.btnWidth -10,
        height = customOptions.btnHeight -10,
        font = native.systemFont,
        fontSize = customOptions.btnfontSize,
        cornerRadius = 25,
        labelColor  = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={customOptions.btnBackground[1], customOptions.btnBackground[2], customOptions.btnBackground[3]}, over={customOptions.btnBackground[1], customOptions.btnBackground[2], customOptions.btnBackground[3], 0.9} },
    })

    CenterBTN.y = myRectangle.y - opt.height / 2
   
    -- First Button
    local firstBTN = widget.newButton({
        onEvent = customOptions.onFirstBtnAction,
        emboss = false,
        shape = "rect",
        width = customOptions.btnWidth,
        height = customOptions.btnHeight,
        font = native.systemFont,
        fontSize = customOptions.btnfontSize,
        labelColor  = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={customOptions.fillColor[1], customOptions.fillColor[2], customOptions.fillColor[3]}, over={0,0,0,0} },
    })
    
    firstBTN.y = myRectangle.y 

    -- Second Button
    local SecondBTN = widget.newButton({
        onEvent = customOptions.onSecondBtnAction,
        emboss = false,
        shape = "rect",
        width = customOptions.btnWidth,
        height = customOptions.btnHeight,
        font = native.systemFont,
        fontSize = customOptions.btnfontSize,
        labelColor  = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={customOptions.fillColor[1], customOptions.fillColor[2], customOptions.fillColor[3]}, over={0,0,0,0} },
    })
    
    SecondBTN.y = myRectangle.y 

    -- Third Button
    local ThirdBTN = widget.newButton({
        onEvent = customOptions.onThirdBtnAction,
        emboss = false,
        shape = "rect",
        width = customOptions.btnWidth,
        height = customOptions.btnHeight,
        font = native.systemFont,
        fontSize = customOptions.btnfontSize,
        labelColor  = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={customOptions.fillColor[1], customOptions.fillColor[2], customOptions.fillColor[3]}, over={0,0,0,0} },
    })
    
    ThirdBTN.y = myRectangle.y 

    if(customOptions.btnPosition =="center" ) then 
        CenterBTN.x = display.contentCenterX
        myRoundedRect.x = display.contentCenterX
        myRoundedRect2.x = display.contentCenterX
        firstBTN.x = display.contentWidth * 0.125
        SecondBTN.x = display.contentWidth * 0.25
        ThirdBTN.x = display.contentWidth * 0.85
    elseif(customOptions.btnPosition =="left") then
        CenterBTN.x = display.contentCenterX / 2
        myRoundedRect.x = display.contentCenterX / 2
        myRoundedRect2.x = display.contentCenterX / 2
        firstBTN.x = customOptions.btnWidth
        SecondBTN.x = display.contentWidth * 0.5
        ThirdBTN.x = display.contentWidth * 0.75
    elseif(customOptions.btnPosition =="right") then
        CenterBTN.x = display.contentCenterX + display.contentCenterX / 2
        myRoundedRect.x = display.contentCenterX + display.contentCenterX / 2
        myRoundedRect2.x = display.contentCenterX + display.contentCenterX / 2
        firstBTN.x = display.contentWidth * 0.125
        SecondBTN.x = display.contentWidth * 0.25
        ThirdBTN.x = display.contentWidth * 0.40
    end

    if( customOptions.icon == nil) then
    else
        local icon = display.newImage( customOptions.icon )
        icon.y = CenterBTN.y
        icon.x = CenterBTN.x
        icon.width = customOptions.iconSize
        icon.height = customOptions.iconSize
    end

    local icon1 = display.newImage( customOptions.icon1 )
    icon1.y = firstBTN.y
    icon1.x = firstBTN.x
    icon1.width = customOptions.iconSize
    icon1.height = customOptions.iconSize

    local icon2 = display.newImage( customOptions.icon2 )
    icon2.y = SecondBTN.y
    icon2.x = SecondBTN.x
    icon2.width = customOptions.iconSize
    icon2.height = customOptions.iconSize

    local icon3 = display.newImage( customOptions.icon3 )
    icon3.y = ThirdBTN.y
    icon3.x = ThirdBTN.x
    icon3.width = customOptions.iconSize
    icon3.height = customOptions.iconSize   
end