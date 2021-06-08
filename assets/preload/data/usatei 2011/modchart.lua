function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
end

function start (song)
	showOnlyStrums = true
	setWindowPos((getScreenWidth() / 2 - getWindowWidth() / 2),  (getScreenHeight() / 2 - getWindowHeight() / 2))
    for i=0,3 do
		tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 365,getActorAngle(i) + 360, 0.6, 'setDefault')
    end
	for i =4,7 do 
		tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,getActorAngle(i) + 360, 0.6, 'setDefault')
	end
end

function update (elapsed)
local currentBeat = (songPos / 1000)*(bpm/60)	
	if bounce then 
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 12 * math.sin((currentBeat * math.pi)), i)
		end
	end
	if morebounce then 
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 24 * math.sin((currentBeat*2 * math.pi)), i)
		end
	end
	if ohlawdhecoming then
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 36 * math.sin((currentBeat*2 * math.pi)), i)
		end
	end
	if wave then
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 256 * math.sin(currentBeat*0.25 * math.pi), i)
		end
	end
	if lowbounce then 
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 4 * math.sin((currentBeat * math.pi)), i)
		end
	end
	if twoplayer then
		for i=0,3 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 365, getActorAngle(i), 0.5)
		end
		for i=4,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 275, getActorAngle(i), 0.5)
		end
	end
	if curStep >= 1184 and curStep < 1200 
	or curStep >= 2200 and curStep < 2216 then
		cameraAngle = cameraAngle + (math.pi * 0.725)
		camHudAngle = camHudAngle + (math.pi * 0.725)
	else
		cameraAngle = 0
		camHudAngle = 0
	end
end

function stepHit (step)
	if step == 1 then
		for i=0,3 do
			tweenFadeOut(i,0, 0.5)
		end
	end
 	if step == 32
	or step == 64 
	or step == 96
	or step == 128 
	or step == 160 
	or step == 192
	or step == 224
	or step == 256 
	or step == 544 
	or step == 1952
	or step == 1984
	or step == 2016
	or step == 2048 then
		bounce = true
	end
	 if step == 56 
	 or step == 80 
	 or step == 120 
	 or step == 144 
	 or step == 184 
	 or step == 208
	 or step == 248
	 or step == 272 
	 or step == 1976
	 or step == 2000
	 or step == 2040
	 or step == 2064 then
		bounce = false
	end
	if step == 720
	or step == 784
	or step == 848
	or step == 912 then
		bounce = false
		morebounce = true
	end
	if step == 736 
	or step == 800
	or step == 864 then
		bounce = true
		morebounce = false
	end
	if step == 928 then
		morebounce = false
		ohlawdhecoming = true
	end
	if step == 416 then
		lowbounce = true
	end
	if step == 544 
	or step == 1944 then
		lowbounce = false
	end
	if step == 2080 
	or step == 2112
	or step == 2144
	or step == 2176 then
		morebounce = true
		wave = true
	end
	if step == 672
	or step == 944
	or step == 2080 then
		wave = true
	end
	if step == 1184 then
		wave = false
		ohlawdhecoming = false
	end
	if step == 1296 then
		twoplayer = true
		for i=0,3 do
			tweenFadeIn(i,1, 0.5)
		end
	end
	--i'm not sure what effect is causing 2P to stutter so 
	--i'm just gonna set everything as false in a single funcntion lol!
	if step == 1695 then
		bounce = false
		morebounce = false
		ohlawdhecoming = false
		wave = false
		lowbounce = false
		twoplayer = false
	end
	if step == 1696 then
		for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.5)
		end
		for i=0,3 do
			tweenFadeOut(i,0, 0.5)
		end
	end
	if step == 2216 then
		for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.5)
		end
		showOnlyStrums = false
		morebounce = false
		wave = false
		camHudAngle = 0
	end
end