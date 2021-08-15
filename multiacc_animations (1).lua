local userInput = game:GetService("UserInputService")
local msgReq = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest

local lp = game:GetService("Players").LocalPlayer
local chara = lp.Character
local hum = chara.Humanoid
local aniDel = 0.05
local ws = 4

local ifEPress = false
local ifQPress = false
local ifRPress = false
local ifWASDPress = false

local animIds = 
{
    "rbxassetid://204328711", --dino walk
    "rbxassetid://126753849", --loop punch
    "rbxassetid://27789359", -- pokie dance shit USED FOR LEVI PART
    "rbxassetid://121572214",--float head anim
    "rbxassetid://313762630", -- levitate anim
    "rbxassetid://180611870", --SCREAM anim
    "rbxassetid://184574340", --hero anim
    "rbxassetid://282574440", --crawl anim
    "rbxassetid://259438880", --turbine anim
    "rbxassetid://163209885", --roar anim
    "rbxassetid://30235165", --pinch nose walking anim
    "rbxassetid://87986341"
}
local function debounce(funct)
	local counter = false
	return function(...)
		if not counter then
			counter = true
			funct(...)
			counter = false
		end
	end
end

local function aniNoDelayFunc(t)
	hum:Move(Vector3.new(300,0,0),true)
	hum:Move(Vector3.new(-300,0,0),true)
	wait(t)
end
local function runAnim(ifPunch, key, animId, strFadeTime, endFadeTime, speed, timePos, ifLooped, weight)
    if weight == nil then
        weight = 1
    end
    chara = lp.Character
    hum = chara.Humanoid
    if ifPunch then
        local dinoAnim = Instance.new("Animation")
        dinoAnim.AnimationId = animIds[1]
        local dinoTrack = hum:LoadAnimation(dinoAnim)
        dinoTrack.Looped = true
        
        local punchAnim = Instance.new("Animation")
        punchAnim.AnimationId = animIds[2]
        local punchTrack = hum:LoadAnimation(punchAnim)
        punchTrack.Looped = true
        
        local headAnim = Instance.new("Animation")
        headAnim.AnimationId = animIds[4]
        local headTrack = hum:LoadAnimation(headAnim)
        headTrack.Looped = true
        
	    headTrack:Play(0.1,1,0)         
	    dinoTrack:Play(0.1,1,0) 
	    hum.WalkSpeed = 1
        --msgReq:FireServer("MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA MUDA ", "All")
	    repeat 
	    	dinoTrack.TimePosition = 0
	    	aniNoDelayFunc(aniDel)

	       	dinoTrack.TimePosition = 0.5
	       	aniNoDelayFunc(aniDel)		
	        punchTrack:Play(0.1,1,9)
	    until ifEPress == false
	    dinoTrack:Stop(0.5) 
	    punchTrack:Stop(0.1)   
	    headTrack:Stop(0)
	    hum.WalkSpeed = ws
	    --msgReq:FireServer("MUDA!", "All")
	    wait(0.2)
	    if hum.MoveDirection ~= Vector3.new(0,0,0) then
	        debounce(runAnim(false,"idle",animIds[11],0.25,0.1,1,0,true))
	    end
    else 
        local anim = Instance.new("Animation")
        anim.AnimationId = tostring(animId)
        --anim.AnimationId = "rbxassetid://27789359"
    
        local track = hum:LoadAnimation(anim)
        track.Looped = ifLooped
        track:Play(strFadeTime, weight, speed)
        track.TimePosition = timePos
        if key == "e" then
            repeat wait() until ifEPress == false
            track:Stop(endFadeTime) 
            if hum.MoveDirection == Vector3.new(0,0,0) and ifEPress == false and ifQPress == false and ifRPress == false and ifWASDPress == false then
                debounce(runAnim(false,"idle2",animIds[6],0.25,0.25,4,0,true))
            end
        elseif key == "q" then
            repeat wait() until ifQPress == false
            track:Stop(endFadeTime)    
            if hum.MoveDirection == Vector3.new(0,0,0) and ifEPress == false and ifQPress == false and ifRPress == false and ifWASDPress == false then
                debounce(runAnim(false,"idle2",animIds[6],0.25,0.25,4,0,true))
            end
	if ifQPress == true then
	        local headCorou = coroutine.wrap(function()
	            wait(0.5)
	            runAnim(false,"q",animIds[4],0.4,0.1,0,0,true)
	        end)
	headCorou()
	end
        elseif key == "r" then
            msgReq:FireServer("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA! ", "All")
            repeat wait() until ifRPress == false
            track:Stop(endFadeTime)   
            if hum.MoveDirection == Vector3.new(0,0,0) and ifEPress == false and ifQPress == false and ifRPress == false and ifWASDPress == false then
                debounce(runAnim(false,"idle2",animIds[6],0.25,0.25,4,0,true))
            end
        elseif key == "idle" then
            repeat wait() until ifEPress == true or ifQPress == true or ifRPress == true or hum.MoveDirection == Vector3.new(0,0,0)
            track:Stop(endFadeTime)  
            ifWASDPress = false
            if hum.MoveDirection == Vector3.new(0,0,0) and ifEPress == false and ifQPress == false and ifRPress == false and ifWASDPress == false then
                debounce(runAnim(false,"idle2",animIds[6],0.25,0.25,4,0,true))
            end
        elseif key == "idle2" then
            repeat wait() until ifEPress == true or ifQPress == true or ifRPress == true or ifWASDPress == true or hum.MoveDirection ~= Vector3.new(0,0,0)
            track:Stop(endFadeTime) 
        end

    end
end
--[[local function noMovingIdleAnimCheck()
    wait(0.2)
    print("fired idle2")
    if hum.MoveDirection == Vector3.new(0,0,0) and ifEPress == false and ifQPress == false and ifRPress == false and ifWASDPress == false then
        debounce(runAnim(false,"idle2",animIds[6],0.25,0.25,2,0,true))
    end
end]]--
--sgReq:FireServer("XYZ on top!", "All")
hum.WalkSpeed = ws

userInput.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.E and not gameProcessedEvent then
	    ifEPress = true
	    debounce(runAnim(true,"e"))
	end
	if input.KeyCode == Enum.KeyCode.Q and not gameProcessedEvent then
	    ifQPress = not ifQPress
	    if ifQPress then
	        local crossCorou = coroutine.wrap(function()
	            runAnim(false,"q",animIds[3],0.25,0.25,0,2,true)
	        end)
	        local headCorou = coroutine.wrap(function()
	            wait(0.5)
	            runAnim(false,"q",animIds[4],0.4,0.1,0,0,true)
	        end)
	        local floatCorou = coroutine.wrap(function()
	            runAnim(false,"q",animIds[5],0.25,0.25,0.3,0,true)
	        end)
	        local legsCorou = coroutine.wrap(function()
	            wait(0.5)
	            runAnim(false,"q",animIds[12],0.4,0.1,0,0.2,true, 0.5)
	        end)
	        hum.WalkSpeed = 1
	        crossCorou()
	        floatCorou()
            headCorou()
            legsCorou()
	    else
	        hum.WalkSpeed = ws
	    end   
	end
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D and not gameProcessedEvent then
        if ifWASDPress == false then
            ifWASDPress = true
            debounce(runAnim(false,"idle",animIds[11],0.25,0.1,1,0,true))
        end
	end
	if input.KeyCode == Enum.KeyCode.R and not gameProcessedEvent then
	    ifRPress = true
	    debounce(runAnim(false,"r",animIds[10],0.1,0.6,5,0,true))
	end
end)

userInput.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.E then
		ifEPress = false
	end
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D then
	    if hum.MoveDirection == Vector3.new(0,0,0) then
            ifWASDPress = false
        end
	end
	if input.KeyCode == Enum.KeyCode.R then
	    ifRPress = false
	end
end)

lp.CharacterAdded:Connect(function(addedChar)
    if addedChar.Name == tostring(lp) then
        addedChar:WaitForChild("Humanoid").WalkSpeed = 4
    end
end)
--[[
local loopSlamAnim = Instance.new("Animation")
loopSlamAnim.AnimationId = "rbxassetid://121572214"
local track = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(loopSlamAnim)
track.Looped = true
track:Play(0,1,0)
local t = 0.05
track.TimePosition = 0
]]--



