	local widget = require("widget")
	local gridView = {}

	function gridView:new(gridX, gridY, photoArray, photoTextArray, columnNumber, paddingX, paddingY, photoWidth, photoHeight, left, bottom, opacity, fontSize, roundRectVisible, textVisible, horizontalScroll, verticalScroll, gridListener)
		local currentX = gridX
		local currentY = gridY

		function onStarButtonRelease(event)
			local btId = event.target.id
			local index = 0
			-- print(btId)

			for i = 1, #photoArray do
				if(btId == "grid"..i) then
					index = i
					break
				end
			end

			gridListener(index)
		end	

		local function scrollListener(event)
			print("-- scrollView --")
		end

		local scrollView = widget.newScrollView(
			{
				left = 0,
				top = 10,
				width = display.contentWidth,
				height = display.contentHeight,
				hideBackground = true,
				--isBounceEnabled = false,
				horizontalScrollDisabled = horizontalScroll,
				verticalScrollDisabled = verticalScroll,
				listener = scrollListener
			}
		)

		function drawGrid()
			for i = 1, #photoArray do
				
				gridView.gridObject = widget.newButton{
					id = "grid"..i,
					defaultFile = photoArray[i], --For Widget V2.0, change the default to defaultFile
			        left = currentX,
			        top = currentY,		
			        width = photoWidth, height = photoHeight,					
					onRelease = onStarButtonRelease
				}		
				gridView.gridObject:toBack()
				local r = 0
				gridView.roundedRect = display.newRoundedRect( currentX + left, currentY + photoHeight - bottom, photoWidth, 35, r )
				gridView.roundedRect:setFillColor( 55, 55, 55, opacity )	
				gridView.roundedRect.isVisible = roundRectVisible
				gridView.roundedRect:toBack()
				--Limit the label length
				--Determine the longest length of the label string
				local bestStringLength = photoWidth / (fontSize/2) - 1

				if(string.len(photoTextArray[i]) > bestStringLength) then
					photoTextArray[i] = string.sub( photoTextArray[i], 0, bestStringLength)
				end
				
				local textPosX = photoWidth / 2 
				gridView.textObject = display.newText( photoTextArray[i], currentX + textPosX, currentY + photoHeight - 20, native.systemFontBold, fontSize )
				gridView.textObject:setTextColor( 255,255,255 )				
				gridView.textObject.isVisible = textVisible
				gridView.textObject:toBack()
				--Update the position of the next item
				currentX = currentX + photoWidth + paddingX

				if(i % columnNumber == 0) then
					currentX = gridX
					currentY = currentY + photoHeight + paddingY
				end		
			
			-- Create the widget
			scrollView:insert(gridView.gridObject)
			
			end	
		end

		drawGrid()	

	end	
	
	return gridView