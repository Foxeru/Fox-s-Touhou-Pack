function start (song)
	BlackFade = makeSprite('BlackFade','blackfade', false)
	setActorX(200,'blackfade')
	setActorY(500,'blackfade')
	setActorAlpha(0,'blackfade')
	setActorScale(2,'blackfade')
end

function update (elapsed)
	if curStep >= 1024 and curStep < 1152 then 
		local currentBeat = (songPos / 1000)*(bpm/60)	
		for i=0,7,1 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin(currentBeat * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 4 * math.sin((currentBeat*2 + i*1.5)), i)
		end
	end
	if curStep >= 1152 and curStep < 2100 then 
		local currentBeat = (songPos / 1000)*(bpm/60)	
		for i=0,7,1 do
			setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin(currentBeat * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 4 * math.sin((currentBeat + i*1.5)), i)
		end
	end

	if curStep == 1920 then 
		showOnlyStrums = true
		for i=0,7 do
			tweenFadeIn(i,0,2)
		end
	end
	if curStep >= 1920 and curStep < 2100 then
		cameraAngle = cameraAngle + 1.500
		camHudAngle = camHudAngle + 1.500
	end
end

function stepHit (step)
	if step == 1920 then
	tweenFadeIn(BlackFade,1,6.7)
	end
end