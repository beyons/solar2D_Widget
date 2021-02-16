-----------------------------------------------------------------------------------------
--
-- authentification.lua
--
-----------------------------------------------------------------------------------------
local twitter = require("plugin.twitter")
local widget = require( "widget" )
require( "library.snackbar" )
local composer = require( "composer" )
local scene = composer.newScene()
local mui = require( "materialui.mui" )
local muiData = require( "materialui.mui-data" )
require ("library.corona_toast")
display.setStatusBar(display.HiddenStatusBar);
native.setProperty("androidSystemUiVisibility", "immersiveSticky");

function scene:create( event )
    local sceneGroup = self.view
    local tabBarHeight = composer.getVariable( "tabBarHeight" )
    -- DMC PLUGIN FACEBOOK APP ID
    local Utils = require( 'library.dmc_utils' )
    local Facebook = require( "library.dmc_facebook" )
    local APP_ID = '633565873881541'
    local APP_URL = 'https://www.facebook.com/connect/login_success.html'
    display.setDefault( "background", 1, 1, 1, 1 )	-- white
    mui.init()

    local function goFirstView()
        composer.setVariable("closure", 1)
        composer.removeScene( "scene.authentification")
        composer.gotoScene( "scene.login")
    end

    -- Facebook with Lua library GraphQL API
    local function onComplete()
        print( "-- Facebook --" )
    end

    local function showAlert( message )
        native.showAlert( "DMC Facebook Plugin", message, { "Fermer" }, onComplete )
    end

    local function facebookHandler( event )
        local data = event.data
        for k,v in pairs(event) do
            print( k,v )
        end
        if event.type == Facebook.LOGIN then
            if event.is_error then
                showAlert( "Error with login: " .. data.message )
            else
                local str = "Successful Login: "
                if event.had_login and not event.had_permissions then
                    str = str .. "existing auth only"
                elseif not event.had_login and event.had_permissions then
                    str = str .. "existing perms only"
                elseif event.had_login and event.had_permissions then
                    str = str .. "existing auth and perms"
                    Facebook:request( 'me' )
                    composer.removeScene( "scene.authentification")
                    composer.gotoScene( "scene.home")
                else
                    str = str .. "neither existing auth nor perms"
                end
                showAlert( str )
            end
        elseif event.type == Facebook.LOGOUT then
            print( "Logout" )
        elseif event.type == Facebook.ACCESS_TOKEN then
            print( "Access token has changed" )
        elseif event.type == Facebook.POST_MESSAGE then
            if event.is_error then
                showAlert( "Error posting message: " .. data.message )
            else
                showAlert( "Message successfully posted" )
            end
        elseif event.type == Facebook.GET_PERMISSIONS then
            if event.is_error then
                showAlert( "Error getting permissions: " .. data.message )
            else
                local params = event.params
                local has_command = (params and params.next_command)
                local has_perms = (data.publish_stream == 1)
                -- see if we're just checking perms for another operation
                if not has_command then
                    showAlert( "Get Permissions successful" )
                else
                    if has_perms then
                        invokeFacebookCommand( params.next_command )
                    else
                        showAlert( "Get Permissions successful, tho perms not good for call" )
                    end
                end
            end
        elseif event.type == Facebook.POST_LINK then
            if event.is_error then
                showAlert( "Error posting link: " .. data.message )
            else
                showAlert( "Link successfully posted" )
            end
        elseif event.type == Facebook.REQUEST then
            if event.path == 'me' then
                if event.is_error then
                    showAlert( "Error in request: " .. data.message )
                else
                    print( "-- Request Data --" )
                    Utils.print( data )
                    showAlert( "Data request successful" )
                end
            end
        end
    end

    local function goFacebookLua()
        Facebook:login( { 'email' } )
    end

    local function onSuccess()
        print("Twitter user " .. twitter.user.screenName .. " successfully logged in!")
        composer.removeScene( "scene.authentification")
        composer.gotoScene( "scene.home")
    end
     
    local function onFail()
        native.showAlert( "Twitter", "Twitter login attempt failed or was cancelled by user", { "Fermer" }, onComplete )
        print("Twitter login attempt failed or was cancelled by user.")
    end

    local function goTwitterLua()
        -- Initializing twitter
        twitter.init("WPOM03NujpdvqRfndygh7U5oA", "jok7zb1BQ9KLX9atjt3mKmYFSz4Wro7p3AAXqxOSoN8nrR1jLV", "https://twitter.com/")
        -- Login twitter
        twitter.login(onSuccess, onFail)
    end

    local function genericFacebookListener( event )
      print( event )
    end

    local paint = {
        type = "gradient",
        color1 = { 0, 0, 0, 0.9 },
        color2 = { 0, 0, 0, 0 },
    }
    
    local myroundedRect = display.newRoundedRect(0, 0, display.contentWidth, display.contentHeight * 0.6, 57)
    myroundedRect.x = display.contentCenterX
    myroundedRect.y = display.screenOriginY + myroundedRect.height / 3
    myroundedRect.width = display.contentWidth - display.screenOriginX
    myroundedRect:setFillColor(0)
    myroundedRect.stroke = paint
    myroundedRect.strokeWidth = 5 

    mui.newRectButton({
        parent = mui.getParent(),
        name = "facebook",
        text = "Facebook",
        width = display.contentWidth * 0.8,
        height = 40,
        radius = 40,
        x = display.contentCenterX - display.screenOriginX,
        y = display.contentCenterY + 80 ,
        touchpoint = true,
        radius = 0,     
        useShadow = false,   
        fontSize = sizeFont,
        font = native.systemFontBold,
        state = {
            value = "off", -- defaults to "off", values: off, on and disabled
            off = {
                iconImage  = "assets/fb.png",
                textColor = {1, 1, 1},
                fillColor = {0.4, 0.41, 1}
            },
            on = {
                textColor = {1, 1, 1},
                fillColor = {0.4, 0.41, 1}
            },
            disabled = {
                textColor = {1, 1, 1},
                fillColor = {.3, .3, .3}
            }
        },
        gradientDirection = "up",
        callBack = goFacebookLua,
        callBackData = {message = "newDialog callBack called"}, 
    })

    mui.newRectButton({
        parent = mui.getParent(),
        name = "twitter",
        text = "Twitter",
        width = display.contentWidth * 0.8,
        height = 40,
        radius = 40,
        x = display.contentCenterX - display.screenOriginX,
        y = display.contentCenterY + 130 ,
        touchpoint = true,
        radius = 0,     
        useShadow = false,   
        fontSize = sizeFont,
        font = native.systemFontBold,
        state = {
            value = "off", -- defaults to "off", values: off, on and disabled
            off = {
                iconImage  = "assets/google.png",
                textColor = {1, 1, 1},
                fillColor = {0, 0.76, 1}
            },
            on = {
                textColor = {1, 1, 1},
                fillColor = {0, 0.76, 1}
            },
            disabled = {
                textColor = {1, 1, 1},
                fillColor = {.3, .3, .3}
            }
        },
        gradientDirection = "up",
        callBack = goTwitterLua,
        callBackData = {message = "newDialog callBack called"}, 
    })

	
	
	

   

    local imageSuffix = display.imageSuffix
    -- print( imageSuffix )
    if(imageSuffix == nil) then
        imageSuffix = "@2x"
    end
	
    myImage = display.newImage( "assets/logo"..imageSuffix..".png", opiton )

    if(imageSuffix == "@4x") then
        myImage.width = 270
        myImage.height = 270
        myImage.x = display.contentCenterX
        myImage.y = display.screenOriginY + ( myImage.height / 2 ) + 40
    else
        myImage.x = display.contentCenterX
        myImage.y = display.screenOriginY + ( myImage.height / 2 ) + 70
    end

    -- snackbar
    function snackHandleEvent()
        -- Ici ecrire le code du bouton du snackbar
        native.requestExit();
    end 
      
    local myClosure = composer.getVariable("closure");
    if myClosure == 0 then
        Snackbar("Fermer l'application", {
            duration = "long", 
            gravity = "bottom", 
            step = 250, 
            direction = "down", 
            listener = snackHandleEvent,
            color = {0.75, 1, 0.5}, 
            marginHeight = 30,
            marginLeft = 10,
            alpha = 0.85,
            title = "Fermer",
            snackbarFontSize = 16,
            buttonColor= {default = {0.75, 1, 0.5}, over = {1, 1, 1, 0.5}}
        })
    end
   
    sceneGroup:insert( myroundedRect )
    sceneGroup:insert( mui.getWidgetProperty("facebook","object") )
    sceneGroup:insert( mui.getWidgetProperty("twitter","object") )
    sceneGroup:insert( myImage )

	-- facebook init
	local initFacebook = function()

        local fb_options = {
            view_type=Facebook.MOBILE_VIEW,
            view_params={
                x=display.contentCenterX, y=display.contentCenterY, w=display.contentWidth, h=display.contentHeight
            },
            app_token_url = APP_TOKEN_URL
        }
    
        Facebook:init( APP_ID, APP_URL, fb_options )
        Facebook:addEventListener( Facebook.EVENT, facebookHandler )
    
    end
    
    initFacebook()
end

local launchURL 
local function onSystemEvent( event )
	print( "yourapp: onSystemEvent [" .. tostring(event.type) .. "] URL: " .. tostring(event.url) ) 
	if event.type == "applicationSuspend" then 
		-- native.requestExit(); 
	elseif event.type == "applicationOpen" and event.url then 
	    -- Prints all launch arguments printTable(event) 
	    launchURL = event.url information.text = "Raw: " .. event.url 
	    print( launchURL ) -- output: coronasdkapp://mycustomstring 
	    local testA = string.find ( launchURL, "=" ) 
	    if tostring(testA) ~= "nil" then 
		    barCodeFinal = string.sub ( launchURL, testA + 1 ) 
		    native.showAlert( "Code Authentification", barCodeFinal, { "Fermer" }, onComplete )
	    end 
    end 
end

Runtime:addEventListener( "system", onSystemEvent )
scene:addEventListener( "create" )
return scene