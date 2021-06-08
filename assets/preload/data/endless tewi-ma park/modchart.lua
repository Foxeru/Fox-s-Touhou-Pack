function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
end

function start (song)
	showOnlyStrums = true
	setWindowPos((getScreenWidth() / 2 - getWindowWidth() / 2),  (getScreenHeight() / 2 - getWindowHeight() / 2))
    for i=0,3 do
	tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 1000,getActorAngle(i) + 360, 0.6, 'setDefault')
    end
	for i =4,7 do 
	tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,getActorAngle(i) + 360, 0.6, 'setDefault')
	end
end

function update (elapsed)
local currentBeat = (songPos / 1000)*(bpm/60)	
	if bounce then 
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 12 * math.sin((currentBeat*2 * math.pi)), i)
		end
	end
	if morebounce then 
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.sin((currentBeat*2 * math.pi)), i)
		end
	end
	if windowbounce then
		setWindowPos((getScreenWidth() / 2 - getWindowWidth() / 2) + 80 * math.sin(currentBeat*0.5 * math.pi), (getScreenHeight() / 2 - getWindowHeight() / 2) + 8 * math.cos(currentBeat*2 * math.pi))
	end
	if morewindowbounce then
		setWindowPos((getScreenWidth() / 2 - getWindowWidth() / 2) + 160 * math.sin(currentBeat*0.5 * math.pi), (getScreenHeight() / 2 - getWindowHeight() / 2) + 16 * math.cos(currentBeat*2 * math.pi))
	end
	if windowdefault then
		setWindowPos((getScreenWidth() / 2 - getWindowWidth() / 2),  (getScreenHeight() / 2 - getWindowHeight() / 2))
	end
	if lowbounce then 
		for i=4,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 4 * math.sin((currentBeat*2 * math.pi)), i)
		end
	end
	if cambounce then
	camHudAngle = camHudAngle - 0.08 * math.cos((currentBeat*0.5 * math.pi))
	end
	if slowcambounce then
	camHudAngle = camHudAngle - 0.16 * math.cos((currentBeat*0.5 * math.pi))
	end
	if default then
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'],i)
			setActorY(_G['defaultStrum'..i..'Y'],i)
        end
	end
end

function stepHit (step)
	if step == 63 then
		lowbounce = true
	end
	if step == 192 then
		lowbounce = false
		bounce = true
	end
	if step == 320 then
		cambounce = true
	end
	if step == 448 then
		cambounce = false
		slowcambounce = true
	end
	if step == 576 then
		slowcambounce = false
		bounce = false
		lowbounce = true
		camHudAngle = 0
	end
	if step == 704 then
		lowbounce = false
		default = true
	end
	if step == 720 then
		default = false
		bounce = true
	end
	if step == 848 then
		bouce = false
		windowbounce = true
		morebounce = true
	end
	if step == 976 then
		windowbounce = false
		morewindowbounce = true
		slowcambounce = true
	end
	if step == 1104 then
		morebounce = false
		morewindowbounce = false
		default = true
		windowdefault = true
		slowcambounce = false
		showOnlyStrums = false
		camHudAngle = 0
	end
	if step == 1105 then
		default = false
		lowbounce = true
	end
end