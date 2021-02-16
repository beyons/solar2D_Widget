local snackbar = nil
local snackbarFont = native.systemFont
local duration, objX, objY
local widget = require("widget")

function Snackbar(label, options)
  
  local function snackbarDestroy()
    snackbar:removeSelf()
    snackbar.label:removeSelf()
    snackbar.button:removeSelf()
  end
  
  local function removeSnackbar()
    if snackbar ~= nil then
      if options.direction == "up" then 
        ydirection = snackbar.y - options.step
      else
        ydirection = snackbar.y + options.step
      end

      transition.to(snackbar, {time = 500, y = ydirection, delay = 2500,  onComplete = snackbarDestroy})
      transition.to(snackbar.label, {time = 500, y = ydirection, delay = 2500,  onComplete = snackbarDestroy})
      transition.to(snackbar.button, {time = 500, y = ydirection, delay = 2500,  onComplete = snackbarDestroy})
    end
  end

  removeSnackbar()

  if options ~= nil then
    if options.duration == "short" then
      duration = 1500
    elseif options.duration == "normal" then
      duration = 3000
    elseif options.duration == "long" then
      duration = 5000
    end

    if options.gravity == "center" then
      objX = display.contentCenterX
      objY = display.contentCenterY
    elseif options.gravity == "top" then
      objX = display.contentCenterX
      objY = 36
    elseif options.gravity == "bottom" then
      objX = display.contentCenterX
      objY = display.viewableContentHeight - 36
    end
  else
     duration = 3000
     objX = display.contentCenterX
     objY = display.contentCenterY
  end

  snackbar = display.newRect (objX, objY, 150, 50)
  snackbar:setFillColor(options.color)
  snackbar.alpha = options.alpha

  snackbar.label = display.newText(label, display.contentCenterX, objY, snackbarFont, options.snackbarFontSize)
  snackbar.button = widget.newButton ({
        x = snackbar.width,
        y = objY,
        id = "bouton1",
        label = options.title,
        fontSize = options.snackbarFontSize,
        labelColor = options.buttonColor,
        onEvent = options.listener
  })
  snackbar.button:setFillColor(0,0,0,0)
  snackbar.width = display.contentWidth * 0.95
  snackbar.button.x = snackbar.width - snackbar.button.width/2 + 30
  snackbar.height = snackbar.label.contentHeight + options.marginHeight
  snackbar.label.x = (snackbar.label.width/2) + 30
  timer.performWithDelay(duration, removeSnackbar)

  return true
end