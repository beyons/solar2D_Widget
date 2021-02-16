-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
print(_VERSION)
-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )
-- Set the background to white
display.setDefault( "background", 0.95 )
-- Cal composer library
local composer = require( "composer" )
-- call database libray and init database
local db = require( "library.corona_database" )
local myScheme = {}
myScheme["__tableName"] = "userAccount"
myScheme["name"] = "TEXT"
myScheme["surname"] = "TEXT"
myScheme["address"] = "TEXT"
myScheme["birthday"] = "TEXT"
myScheme["phone"] = "INTEGER"
myScheme["email"] = "TEXT"
myScheme["speciality"] = "TEXT"
myScheme["disponibility"] = "TEXT"
db.init( "appipc.db", myScheme )
-- Differents size
sizePageTitle = 20
sizeTxtTitle = 16
sizeTxt = 14
sizeInput = 16
roudedCirc = 55
-- Call Composer scene
composer.gotoScene( "view.home" )