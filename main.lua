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
local function removeFlake(target)
        target:removeSelf()
        target = nil
end

local function spawnSnowFlake()
        local flake = display.newCircle(0,0,3.5)
        flake.x = math.random(1,500)
        flake.y = 20
        local wind = math.random(100) -200
        transition.to(flake,{time=math.random(2000) + 800, y = display.contentHeight + 10, x = flake.x + wind, onComplete=removeFlake})
end

local function makeSnow(event)
      if math.random(3) == 1 then -- adjust speed here by making the random number higher or lower
            spawnSnowFlake()
      end
      return true
end

Runtime:addEventListener("enterFrame",makeSnow)

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
local sky = display.newImage( "BG.png", 240,155)

local baseline = 295

-- a bunch of foliage
local item = {}
item[1] = display.newImage( "Tree_1.png" )
item[1].xScale = 0.4; item[1].yScale = 0.4
item[1].anchorY = BOTTOM_REF
item[1].x = 1; item[1].y = baseline-26
item[1].dx = 0.4
item[2] = display.newImage( "Tree_2.png" )
item[2].xScale = 0.6; item[2].yScale = 0.6
item[2].anchorY = BOTTOM_REF
item[2].x = 50; item[2].y = baseline-29
item[2].dx = 0.4
item[8] = display.newImage( "Tree_2.png" )
item[8].xScale = 0.4; item[8].yScale = 0.4
item[8].anchorY = BOTTOM_REF
item[8].x = 500; item[8].y = baseline-29
item[8].dx = 0.4
item[7] = display.newImage( "Stone.png" )
item[7].xScale = 0.6; item[7].yScale = 0.5
item[7].anchorY = BOTTOM_REF
item[7].x = 100; item[7].y = baseline-30
item[7].dx = 0.4
item[3] = display.newImage( "Crate.png" )
item[3].xScale = 0.4; item[3].yScale = 0.4
item[3].anchorY = BOTTOM_REF
item[3].x = 50; item[3].y = baseline-30
item[3].dx = 0.4
item[4] = display.newImage( "Crystal.png" )
item[4].xScale = 0.4; item[4].yScale = 0.4
item[4].anchorY = BOTTOM_REF
item[4].x = 200; item[4].y = baseline-30
item[4].dx = 0.4
item[5] = display.newImage( "Igloo.png" )
item[5].xScale = 0.3; item[5].yScale = 0.3
item[5].anchorY = BOTTOM_REF
item[5].x = 100; item[5].y = baseline-29
item[5].dx = 0.4
item[6] = display.newImage( "Sign_2.png" )
item[6].xScale = 0.6; item[6].yScale = 0.6
item[6].anchorY = BOTTOM_REF
item[6].x = 200; item[6].y = baseline-30
item[6].dx = 0.4
item[9] = display.newImage( "SnowMan.png" )
item[9].xScale = 0.5; item[9].yScale = 0.5
item[9].anchorY = BOTTOM_REF
item[9].x = 400; item[9].y = baseline-29
item[9].dx = 0.4
item[10] = display.newImage( "Title.png" )
item[10].xScale = 0.5; item[10].yScale = 0.5
item[10].anchorY = BOTTOM_REF
item[10].x = 960; item[10].y = baseline-180
item[10].dx = 0.6





-- an image sheet with a cat
local sheet1 = graphics.newImageSheet( "Santa.png", { width=500, height=500, numFrames=10 } )

-- play 15 frames every 500 ms
local instance1 = display.newSprite( sheet1, { name="Santa", start=1, count=9, time=800} )
instance1.x = display.contentWidth / 5+50
instance1.y = baseline -155
instance1.xScale = 0.5
instance1.yScale = 0.5
instance1:play()

-- A sprite sheet with a green dude
local sheet2 = graphics.newImageSheet( "zombie.png", { width=500, height=500, numFrames=5 } )

-- play 15 frames every 500 ms
local instance2 = display.newSprite( sheet2, { name="man", start=1, count=4, time=600 } )
instance2.x = display.contentWidth / 5 + 280
instance2.y = baseline - 152
instance2.xScale = 0.5
instance2.yScale = 0.5
instance2:play()

-- Grass
-- This is doubled so we can slide it
-- When one of the grass images slides offscreen, we move it all the way to the right of the next one.
local grass = display.newImage( "floor.png" )
grass.anchorX = LEFT_REF
grass.x = 0
grass.y = baseline - 45
local grass2 = display.newImage( "floor.png" )
grass2.anchorX = LEFT_REF
grass2.x = 480
grass2.y = baseline - 45



-- solid ground, doesn't need to move
local ground = display.newRect( 0, baseline, 480, 70 )
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
	for i = 1, #item, 1 do
		item[i].x = item[i].x - item[i].dx * tDelta * 0.2
		if (item[i].x + item[i].contentWidth) < 0 then
			item[i]:translate( 480 + item[i].contentWidth * 2, 0 )
		end
	end
end

-- Start everything moving
Runtime:addEventListener( "enterFrame", move );