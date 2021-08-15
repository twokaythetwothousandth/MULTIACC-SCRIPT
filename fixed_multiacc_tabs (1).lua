local msgReq = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local chara = lp.Character
local humRoot = chara.HumanoidRootPart
local camera = workspace.CurrentCamera

local mainPlr = plrs["xyzdrippy"]
local mainPlrChara = mainPlr.Character
local mainPlrHumRoot = mainPlrChara.HumanoidRootPart
local mainPlrHum = mainPlrChara.Humanoid

local targetPlr
local targetPlrChara
local targetPlrHumRoot

local fullRot = math.rad(360)
local radius = 5
local timeRot = 1.5
local height = 5
local degree = 360
local force = 10000
local flingPos = 0
local flingDis = 8
local prefix = "."

local ifQPress = false
local ifSpam = false
local ifFling = false
local ifFlingCounter = false

local x, z
local x2, z2
local i = 0
local enabled = false

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
		"rbxassetid://30235165" --pinch nose walking anim
}

local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
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

local function runAnim(animId, strFadeTime, endFadeTime, speed, timePos, ifLooped)
	chara = lp.Character
	hum = chara.Humanoid

	local anim = Instance.new("Animation")
	anim.AnimationId = tostring(animId)
	local track = hum:LoadAnimation(anim)
	track.Looped = ifLooped
	track:Play(strFadeTime, 1, speed)
	track.TimePosition = timePos
	
	repeat wait() until ifQPress == false
	track:Stop(endFadeTime)    
end

local function getPos(ang, dis)
	local x = math.cos(math.rad(ang)) * dis
	local y = math.sin(math.rad(ang)) * dis
	return x,y
end

local function orbit()
	local crossCorou = coroutine.wrap(function()
		runAnim(animIds[3],0.25,0.25,0,2,true)
	end)
	local headCorou = coroutine.wrap(function()
		wait(0.5)
		runAnim(animIds[4],0.4,0.1,0,0,true)
	end)
	enabled = true
	ifQPress = true
	local platform = Instance.new("Part",workspace)
	platform.Anchored = true
	platform.Size = Vector3.new(4,1,4)
	platform.Transparency = 0.5
	platform.CanCollide = true

	local lookAtPart = Instance.new("Part",workspace)
	lookAtPart.Anchored = true
	lookAtPart.Size = Vector3.new(1,1,1)
	lookAtPart.Transparency = 0.5
	lookAtPart.CanCollide = true

	crossCorou()
	headCorou()

	repeat
		i = i + timeRot
		x, z = getPos(degree + i, radius)
		x2, z2 = getPos(degree + i, radius + 10)
		platform.CFrame = CFrame.new(mainPlrHumRoot.Position.X + x, mainPlrHumRoot.Position.Y - 3.5 + height, mainPlrHumRoot.Position.Z + z) * CFrame.Angles(mainPlrHumRoot.CFrame:ToEulerAnglesXYZ())
		lookAtPart.CFrame = CFrame.new(mainPlrHumRoot.Position.X + x2, mainPlrHumRoot.Position.Y + height, mainPlrHumRoot.Position.Z + z2) * CFrame.Angles(mainPlrHumRoot.CFrame:ToEulerAnglesXYZ())
		humRoot.CFrame = CFrame.new(mainPlrHumRoot.Position.X + x, mainPlrHumRoot.Position.Y + height, mainPlrHumRoot.Position.Z + z)  
		humRoot.CFrame = CFrame.lookAt(humRoot.Position, lookAtPart.Position)
		wait()
	until enabled == false   
	i = 0
	platform:Destroy()
	lookAtPart:Destroy()
end

local function fling(animationTrack)
    chara = lp.Character
    humRoot = chara.HumanoidRootPart
    hum = chara.Humanoid
    mainPlrChara = mainPlr.Character
    mainPlrHumRoot = mainPlrChara.HumanoidRootPart
    mainPlrHum = mainPlrChara.Humanoid
    if ifFlingCounter == false then
        ifflingCounter = true
        local animationId = animationTrack.Animation.AnimationId
	if animationId == animIds[1] then
	    print("GOTCHU")
	    local allAnims = mainPlrHum:GetPlayingAnimationTracks()
	    local counterFling = 0

        local enabledPH = enabled
        if enabled == true then
            enabled = false
            ifQPress = false
        end
 
        local flingPart = Instance.new("Part",workspace)
        flingPart.Anchored = true
        flingPart.CanCollide = false
        flingPart.Size = Vector3.new(1,1,1)
        flingPart.Transparency = 0.25

        local humRootBP = Instance.new("BodyPosition",humRoot)
        humRootBP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        humRootBP.D = 200

        local humRootAV = Instance.new("BodyAngularVelocity",humRoot)
        humRootAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        humRootAV.AngularVelocity = Vector3.new(0, force, 0)
        camera.CameraSubject = mainPlrHum
        while wait(0.05) do
            allAnims = mainPlrHum:GetPlayingAnimationTracks()
            for i,v in pairs(allAnims) do
                if allAnims[i].Animation.AnimationId == animIds[1] then
                    flingPart.CFrame = CFrame.new(mainPlrHumRoot.Position + (mainPlrHumRoot.CFrame.lookVector * flingDis) + (mainPlrHumRoot.CFrame.rightVector * flingPos))                        
                    humRootBP.Position = flingPart.Position
                else
                    flingPart.CFrame = CFrame.new(mainPlrHumRoot.Position + (mainPlrHumRoot.CFrame.lookVector * flingDis) + (mainPlrHumRoot.CFrame.rightVector * flingPos))
                    humRootBP.Position = flingPart.Position
                    counterFling = counterFling + 1
                end
            end
            if counterFling >= #allAnims then
                break
            end
            counterFling = 0
        end
        local humRootBGTP = Instance.new("BodyGyro", humRoot)
        humRootBGTP.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        humRootBGTP.D = 200
        humRootBGTP.CFrame = humRoot.CFrame
        humRootBGTP.CFrame = CFrame.new(humRoot.Position) * CFrame.Angles(mainPlrHumRoot.CFrame:ToEulerAnglesXYZ())
        humRootAV:Destroy()
        humRootBP:Destroy()
        flingPart:Destroy()
        wait(0.1)
        humRootBGTP:Destroy()
        camera.CameraSubject = hum

                
        if enabledPH == true then
            orbit()
        
        end
        ifflingCounter = false
	end
	end
end

print("go!")

local function initialize(mainPlr)
local yay = mainPlr.Chatted:Connect(function(msg)
	local msgSplit = string.split(msg, " ")
	print(tostring(msgSplit[1]) .. "|" .. tostring(msgSplit[2]) .. "|" .. tostring(msgSplit[3]))
	print(msg)
	if string.sub(msgSplit[1],1,1) == prefix then
	    chara = lp.Character
        humRoot = chara.HumanoidRootPart
        hum = chara.Humanoid
        mainPlrChara = mainPlr.Character
        mainPlrHumRoot = mainPlrChara.HumanoidRootPart
        mainPlrHum = mainPlrChara.Humanoid
	    print("cmd check!")
		if msgSplit[1]:lower() == (prefix .. "form") then
		    if enabled == false then
		        orbit()
		    end
		elseif msgSplit[1]:lower() == (prefix .. "unform") then
			enabled = false
			ifQPress = false
		elseif msgSplit[1]:lower() == (prefix .. "reform") then
			enabled = false
			ifQPress = false
			wait()
			orbit()
		elseif msgSplit[1]:lower() == (prefix .. "assign") then
			if string.match(lp.Name:lower(), msgSplit[2]:lower()) ~= nil and tonumber(msgSplit[3]) ~= nil then				
				degree = msgSplit[3]
				msgReq:FireServer("XYZ: Assigned to " .. degree .. " degrees.", "All")
			end
		elseif msgSplit[1]:lower() == (prefix .. "target") then
			for i,v in pairs(plrs:GetChildren()) do
			     print(v.Name:lower())
				if string.match(v.Name:lower(), msgSplit[2]:lower()) ~= nil then
					targetPlr = plrs[v.Name]
					targetPlrChara = targetPlr.Character
					targetPlrHumRoot = targetPlrChara.HumanoidRootPart
					msgReq:FireServer("XYZ: Targeting " .. v.Name, "All")
				end
			end
		elseif msgSplit[1]:lower() == (prefix .. "muda") then
			if msgSplit[2]:lower() == "start" then
			    print("GOTCHU")
				ifFling = true
				local enabledPH = enabled
				local ifQPressPH = ifQPress
				print("GOTCHU")
				local targetPlrHumRootSavedPosX, targetPlrHumRootSavedPosY, targetPlrHumRootSavedPosZ = targetPlrHumRoot.Position.X, targetPlrHumRoot.Position.Y, targetPlrHumRoot.Position.Z

				if enabled == true or ifQPress == true then				
					enabled = false
					ifQPress = false
				end
				
				local humRootBP = Instance.new("BodyPosition",humRoot)
				humRootBP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				humRootBP.D = 200
				
				local humRootBT = Instance.new("BodyThrust",humRoot)
				humRootBT.Location = humRoot.Position
				humRootBT.Force = Vector3.new(force,0,force)
				repeat
					humRootBP.Position = targetPlrHumRoot.Position
					print("looping")
					wait()
				until ifFling == false or Vector3.new(math.abs(targetPlrHumRoot.Position.X - targetPlrHumRootSavedPosX), math.abs(targetPlrHumRoot.Position.Y - targetPlrHumRootSavedPosY), math.abs(targetPlrHumRoot.Position.Z - targetPlrHumRootSavedPosZ)) <= Vector3.new(1000,1000,1000)
				print("destroyed")

				humRootBP.D = 1000
				humRootBT:Destroy()
				humRootBP:Destroy()
				for i = 0, 20 do
				    aniNoDelayFunc(0.1)
				end
				wait(5)
				if enabledPH == true or ifQPressPH == true then				
					orbit()
				end
			elseif msgSplit[2]:lower() == "stop" then
			    ifFling = false
			    print("false nb")

			end
		elseif msgSplit[1]:lower() == (prefix .. "spam") then
			if msgSplit[2]:lower() == "random" and tonumber(msgSplit[3]) ~= nil then
				local randomStr
				local randomized
				ifSpam = true
				repeat
				    randomStr = ""
					for i = 0, 90 do
					    randomized = math.random(1,#chars)
						randomStr = randomStr .. string.sub(chars, randomized, randomized)
					end
					msgReq:FireServer(randomStr, "All")
					wait(tonumber(msgSplit[3]))
				until ifSpam == false
			elseif msgSplit[2] ~= nil then
                if string.sub(msgSplit[2],1,1) == "\"" then
                    local counter = 0
                    local msgSplit2PH = string.sub(msgSplit[2],2,#msgSplit[2])
                    local strPH = msgSplit2PH
                    for i,v in pairs(msgSplit) do
                        print(i)
                        if string.sub(v, #v, #v) == "\"" then
                            counter = i
                            strPH = strPH .. " " .. string.sub(v,1, #v - 1)
                            break
                        elseif string.sub(v, #v, #v) ~= "\"" and v ~= msgSplit[1] and v ~= msgSplit[2] then
                            counter = i
                            strPH = strPH .. " " .. v
                        end
                    end
                    if tonumber(msgSplit[counter + 1]) ~= nil then
    				    ifSpam = true
				        repeat 
					        msgReq:FireServer(strPH, "All")
					        wait(tonumber(msgSplit[counter + 1]))
				        until ifSpam == false                             
                    else
    				    ifSpam = true
				        repeat 
					        msgReq:FireServer(strPH, "All")
					        wait(1)
				        until ifSpam == false                          
                    end
                elseif tonumber(msgSplit[3]) then
				    ifSpam = true
				    repeat 
					    msgReq:FireServer(msgSplit[2], "All")
					    wait(tonumber(msgSplit[3]))
				    until ifSpam == false                    
                end
			end
		elseif msgSplit[1]:lower() == (prefix .. "unspam") then
		    ifSpam = false
		elseif msgSplit[1]:lower() == (prefix .. "timerot") or msgSplit[1]:lower() == (prefix .. "speed") then
		    if tonumber(msgSplit[2]) ~= nil then
		        timeRot = tonumber(msgSplit[2])
		        msgReq:FireServer("XYZ: Set timeRot variable to " .. timeRot .. ".", "All")
		    else
		        msgReq:FireServer("XYZ: Invalid value!", "All")
		    end
		elseif msgSplit[1]:lower() == (prefix .. "radius") then
		    if tonumber(msgSplit[2]) ~= nil then
		        radius = tonumber(msgSplit[2])
		        msgReq:FireServer("XYZ: Set radius to " .. radius .. ".", "All")
		    else
		        msgReq:FireServer("XYZ: Invalid value!", "All")
		    end
		elseif msgSplit[1]:lower() == (prefix .. "flingdis") then
			if string.match(lp.Name:lower(), msgSplit[2]:lower()) ~= nil and tonumber(msgSplit[3]) ~= nil then				
				flingDis = tonumber(msgSplit[3])
		        msgReq:FireServer("XYZ: Set flingDis variable to " .. flingDis .. ".", "All")
			end
		elseif msgSplit[1]:lower() == (prefix .. "flingpos") then
			if string.match(lp.Name:lower(), msgSplit[2]:lower()) ~= nil and tonumber(msgSplit[3]) ~= nil then				
				flingPos = tonumber(msgSplit[3])
		        msgReq:FireServer("XYZ: Set flingPos variable to " .. flingPos .. ".", "All")
			end
		elseif msgSplit[1]:lower() == (prefix .. "var") or msgSplit[1]:lower() == (prefix .. "stats") then
		    print("radius = " .. radius .. ", timeRot = " .. timeRot .. ", degrees = " .. degree .. ", flingPos/flingDis = " .. flingPos .. ", " .. flingDis)
		elseif msgSplit[1]:lower() == (prefix .. "resetscript") then
		    msgReq:FireServer("XYZ: Reseting...", "All")
		    enabled = false
			ifQPress = false
			ifSpam = false
            ifFling = false
            ifFlingCounter = false
            mainPlrChara = mainPlr.Character
            mainPlrHumRoot = mainPlrChara.HumanoidRootPart
            mainPlrHum = mainPlrChara.Humanoid
            initialize(mainPlr)
            yay:Disconnect()
		end
	else
		msgReq:FireServer(msg, "All")
	end
end)

mainPlrHum.AnimationPlayed:Connect(function(animationTrack)
    debounce(fling(animationTrack))
end)
end

initialize(mainPlr)



