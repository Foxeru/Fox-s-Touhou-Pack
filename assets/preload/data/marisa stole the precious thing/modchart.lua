local w = 0.0
local w1 = 0.0
local w2 = 0.0
local w3 = 0.0
local t = 0
local lastX = 0
local lastY = 0

function lerp(from, to, t)
    return from + (to - from) * clamp(t, 0, 1)
end

function clamp(num, min, max)
    if num < min then
        num = min
    elseif num > max then
        num = max    
    end
    
    return num
end

function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
end

function start (song)
	resizeWindow(960, 540)
	w = getScreenWidth()
	w1 = (w / 4) * 2 + getWindowWidth() - 375 -- 100 is a general offset idk might work lol!
	w2 = (w / -2.5) * 2 + getWindowWidth() - 1075
	w3 = (w / 2000) * 3.575
	showOnlyStrums = true
	setWindowPos((getScreenWidth() / 2 - getWindowWidth() / 2),  (getScreenHeight() / 2 - getWindowHeight() / 2))
    for i=0,3 do
		tweenFadeOut(i,0, 0)
		tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 365,getActorAngle(i) + 360, 0.6, 'setDefault')
    end
	for i =4,7 do 
		tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,getActorAngle(i) + 360, 0.6, 'setDefault')
	end
end

function update (elapsed)
local currentBeat = (songPos / 1000)*(bpm/60)
	if abibibubui then -- i don't know how to fix this the speed is inconsistent for whatever reason
		if getWindowX() < w1 then
			setWindowPos(getWindowX() + w3, (getScreenHeight() / 2 - getWindowHeight() / 2) + 8 * math.cos(currentBeat * math.pi))
		else
			setWindowPos(w2, (getScreenHeight() / 2 - getWindowHeight() / 2) + 8 * math.cos(currentBeat * math.pi)) 
		end
	end
	if twoplayer then
		for i=0,3 do
			tweenFadeIn(i,1, 0)
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 365, getActorAngle(i), 0.5)
		end
		for i=4,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 275, getActorAngle(i), 0.5)
		end
	end
	if centerplayer then
		for i=0,3 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.5)
		end
		for i=4,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.5)
		end
	end
	if windowdefault then
		if t <= 1 then
			t = t + elapsed
			setWindowPos(lerp(lastX,(getScreenWidth() / 2 - getWindowWidth() / 2),t * 1.5),lerp(lastY,(getScreenHeight() / 2 - getWindowHeight() / 2), t * 1.5))
		end
    end
end
--i hate coding
function stepHit(step)
	if step == 496 then
		twoplayer = true
	end
	if step == 512 then
		abibibubui = true
	end
	if step == 568 then
		abibibubui = false
		t = 0
		lastX = getWindowX()
		lastY = getWindowY()
		windowdefault = true
	end
	if step == 575 then
		windowdefault = false
		abibibubui = true
	end
	if step == 632 then
		abibibubui = false
		t = 0
		lastX = getWindowX()
		lastY = getWindowY()
		windowdefault = true
	end
	if step == 640 then
		windowdefault = false
		abibibubui = true
	end
	if step == 704 then
		abibibubui = false
		t = 0
		lastX = getWindowX()
		lastY = getWindowY()
		windowdefault = true
		twoplayer = false
		centerplayer = true
	end
	if step == 766 then
		for i=0,3 do
			tweenFadeOut(i,0, 0.5)
		end
	end
	if step == 1312 then
		showOnlyStrums = false
		resizeWindow(1280, 720)
	end
end