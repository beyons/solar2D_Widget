-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
require( "widget_bottomBar" )

local function bottomBarCick()
    print(0)
end

local function actionBtn1()
    print(1)
end
local function actionBtn2()
    print(2)
end
local function actionBtn3()
    print(3)
end

local panel = widget.newButtonBar{
    width = display.contentWidth,
    height = 58,
    fillColor = { 0, 0.63, 1 },
    fillColor2 = { 0, 0, 0 },
    centerLabel = nil,
    btnWidth = 50,
    btnHeight = 50,
    btnfontSize = 13,
    btnPosition = "right",
    btnBackground = { 1, 0.2, 0.3 },
    btnColor = { 1, 1, 1 },
    iconSize = 25,
    icon = "add.png",
    icon1 = "menu.png",
    icon2 = "info.png",
    icon3 = "settings.png",
    onCenterBtnAction = bottomBarCick,
    onFirstBtnAction = actionBtn1,
    onSecondBtnAction = actionBtn2,
    onThirdBtnAction = actionBtn3,
}