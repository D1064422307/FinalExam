-- 
-- Abstract: JungleScene sample project
-- Demonstrates sprite sheet animations, with different frame rates
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see https://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.

-- Plants are from http://blender-archi.tuxfamily.org/Greenhouse
-- and are subject to creative commons license, http://creativecommons.org/licenses/by/3.0/
--
--	Supports Graphics 2.0
---------------------------------------------------------------------------------------
centerX = RIGHT_REF
centerY = display.contentCenterY +1 
centerX = display.contentCenterX +5 

actualW = display.actualContentWidth
actualH = display.actualContentHeight

local physics = require( "physics" )
physics.start()

local snow = {}
local sCounter = 1
local sTimer

local function createSnow()
	local randomSize = math.random( 1, 5 )
	local randomX = math.random( centerX - actualW/0.5, centerY + actualW/10 )
	local randomRightLeft = math.random( 50, 150)
	local randomDown = math.random( 101, 150 )
	snow[sCounter] = display.newCircle( randomX, centerY - actualH/2 - 100, randomSize )
	snow[sCounter].value = sCounter
	physics.addBody( snow[sCounter], "dynamic" )
	snow[sCounter].gravityScale = 0 
	snow[sCounter]:setLinearVelocity( randomDown, randomRightLeft )
	snow[sCounter].alpha = 1
	sCounter = sCounter + 1
end

sTimer = timer.performWithDelay( 50, createSnow, -1 )

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- Define reference points locations anchor ponts
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5

display.setStatusBar( display.HiddenStatusBar )

-- The sky as background
local sky = display.newImage( "background.jpg", 90,130 )

local baseline = 280

-- a bunch of foliage
local tree = {}
tree[1] = display.newImage( "tree.png" )
tree[1].xScale = 0.3; tree[1].yScale = 0.3
tree[1].anchorY = BOTTOM_REF
tree[1].x = 20; tree[1].y = baseline
tree[1].dx = 0.1
tree[2] = display.newImage( "tree2.png" )
tree[2].xScale = 0.6; tree[2].yScale = 0.6
tree[2].anchorY = BOTTOM_REF
tree[2].x = 120; tree[2].y = baseline
tree[2].dx = 0.2
tree[3] = display.newImage( "tree2.png" )
tree[3].xScale = 0.6; tree[3].yScale = 0.6
tree[3].anchorY = BOTTOM_REF
tree[3].x = 200; tree[3].y = baseline
tree[3].dx = 0.3
tree[4] = display.newImage( "tree.png" )
tree[4].xScale = 0.4; tree[4].yScale = 0.4
tree[4].anchorY = BOTTOM_REF
tree[4].x = baseline; tree[4].y = baseline
tree[4].dx = 0.4
tree[5] = display.newImage( "tree.png" )
tree[5].xScale = 0.8; tree[5].yScale = 0.8
tree[5].anchorY = BOTTOM_REF
tree[5].x = 300; tree[5].y = baseline
tree[5].dx = 0.5
tree[6] = display.newImage( "tree2.png" )
tree[6].xScale = 0.4; tree[5].yScale = 0.4
tree[6].anchorY = BOTTOM_REF
tree[6].x = 320; tree[6].y = baseline
tree[6].dx = 0.6
tree[7] = display.newImage( "tree.png" )
tree[7].xScale = 0.4; tree[7].yScale = 0.4
tree[7].anchorY = BOTTOM_REF
tree[7].x = 380; tree[7].y = baseline
tree[7].dx = 0.7
tree[8] = display.newImage( "tree2.png" )
tree[8].xScale = 0.6; tree[8].yScale = 0.6
tree[8].anchorY = BOTTOM_REF
tree[8].x = 420; tree[8].y = baseline
tree[8].dx = 0.8

-- an image sheet with a cat
local sheet1 = graphics.newImageSheet( "satan.png", { width=500, height=500, numFrames=19 } )

-- play 15 frames every 500 ms
local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=18, time=650 } )
instance1.x = display.contentWidth / 10+300
instance1.y = baseline -100
instance1.xScale = 0.5
instance1.yScale = 0.5
instance1:play()

-- A sprite sheet with a green dude
local sheet2 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=12 } )

-- play 15 frames every 500 ms
local instance2 = display.newSprite( sheet2, { name="man", start=1, count=12, time=2000 } )
instance2.x = display.contentWidth / 5 + 40
instance2.y = baseline - 85
instance2.xScale = 2
instance2.yScale = 2
instance2:play()


-- Grass
-- This is doubled so we can slide it
-- When one of the grass images slides offscreen, we move it all the way to the right of the next one.
local grass = display.newImage( "grass.png" )
grass.anchorX = LEFT_REF
grass.x = 0
grass.y = baseline - 20
local grass2 = display.newImage( "grass.png" )
grass2.anchorX = LEFT_REF
grass2.x = 480
grass2.y = baseline - 20

-- solid ground, doesn't need to move
local ground = display.newRect( 0, baseline, 480, 90 )
ground:setFillColor( 0x31/255, 0x5a/255, 0x18/255 )
ground.anchorX = LEFT_REF
ground.anchorY = TOP_REF

-- A per-frame event to move the elements
local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )

	grass.x = grass.x - xOffset*2
	grass2.x = grass2.x - xOffset*2
	
	if (grass.x + grass.contentWidth) < 0 then
		grass:translate( 480 * 2, 0)
	end
	if (grass2.x + grass2.contentWidth) < 0 then
		grass2:translate( 480 * 2, 0)
	end
	
	local i
	for i = 1, #tree, 1 do
		tree[i].x = tree[i].x - tree[i].dx * tDelta * 0.2
		if (tree[i].x + tree[i].contentWidth) < 0 then
			tree[i]:translate( 480 + tree[i].contentWidth * 2, 0 )
		end
	end
end

-- Start everything moving
Runtime:addEventListener( "enterFrame", move );