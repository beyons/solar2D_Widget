    
function startDrag(event)
    local swipeLength = math.abs(event.x - event.xStart) 
    local swipeLengtyh = math.abs(event.y - event.yStart) 
    print(swipeLengtyh)
    local t = event.target
    local phase = event.phase
    if "began" == phase then
        return true
    elseif "moved" == phase then
        if event.xStart > event.x and swipeLength > 20 then 
            --print("swipe Left")
        else
            --print("swipe Right")
        end

        if event.yStart > event.y and swipeLengtyh > 20 then
            --print("swipe up")
        else
            --print("swipe down")
        end
    elseif "ended" == phase or "cancelled" == phase then
    end
end
--Runtime:addEventListener("touch",startDrag)