--=================================================================================
--Brush Scripts
--=================================================================================

BrushTable = {}

function Test(trigger)
	print(trigger.activator:GetName())
	print("top kek")
end

function BrushStart(trigger)
	local name = trigger.caller:GetEntityIndex()
	--Say(brush, "You have entered: " .. name, false)
	if BrushTable[name] == nil then
		BrushTable[name] = {["entities"] = {}, ["revealers"] = {}} 					
	end

	if trigger.activator:GetUnitName() == "npc_lol_brush_vision" then 				
		--print(trigger.activator:GetUnitName())									
		BrushTable[name]["revealers"][trigger.activator] = true 					
		--print(trigger.activator:GetUnitName())
	else
		--print(trigger.activator:GetName())
		if trigger.activator:GetUnitName() ~= "npc_dota_courier" then
			giveUnitDataDrivenModifier(trigger.activator, trigger.activator, "modifier_lol_in_brush", -1)
		end
		BrushTable[name]["entities"][trigger.activator] = true
		--print("starting updating for " .. name)

		thisEntity:SetContextThink("brush-thinker-for-" .. name, function(trigger)
				-- loops through each revealer
				for revealer, v in pairs(BrushTable[name]["revealers"]) do 
					local largest_vr = 0
					-- This gets the largest vision the revealer should set its vision to								
					for entity, v in pairs(BrushTable[name]["entities"]) do
						-- Checks if the entity is touching the brush
						if trigger:IsTouching(entity) then
							-- Only gets vision for things on correct team
							if entity:GetTeam() == revealer:GetTeam() then
								local entity_vr = entity:GetCurrentVisionRange()
								local d = CalcDistanceBetweenEntityOBB(entity, revealer)
								largest_vr = math.max(entity_vr - d, largest_vr)
							end
						-- Else: remove it from the table, this prevents the script from crashing when something dies in the brush
						else
							--print("entity removed")
							BrushTable[name]["entities"][entity] = nil
						end
					end
					-- this changes vision
					revealer:SetDayTimeVisionRange(largest_vr)
					revealer:SetNightTimeVisionRange(largest_vr)
				end

				-- This will check if there are any entities remaining from your team inside the brush, if not. It stops the checking loop
				for revealer, v in pairs(BrushTable[name]["revealers"]) do
					for entity, v in pairs(BrushTable[name]["entities"]) do
						-- if there's an entity of the team as the revealer
						if entity:GetTeam() == revealer:GetTeam() then
							return 0.05
						end
					end
				end
				return nil
			end, 0)
	end
end
 
function BrushEnd(trigger)
	trigger.activator:RemoveModifierByName("modifier_lol_in_brush")
	BrushTable[trigger.caller:GetEntityIndex()]["entities"][trigger.activator] = nil
	--Say(brush, "You have entered: " .. "brush" .. trigger.caller:GetEntityIndex(), false)
end

BrushTable2 = {}
 
function BrushStart2(trigger)
	local name = trigger.caller:GetEntityIndex()
	--Say(brush, "You have entered: " .. name, false)
	if BrushTable2[name] == nil then
		BrushTable2[name] = {["entities"] = {}, ["revealers"] = {}} 					
	end

	if trigger.activator:GetUnitName() == "npc_lol_brush_vision" then 				
		--print(trigger.activator:GetUnitName())									
		BrushTable2[name]["revealers"][trigger.activator] = true 					
		--print(trigger.activator:GetUnitName())
	else
		--print(trigger.activator:GetName())
		if trigger.activator:GetUnitName() ~= "npc_dota_courier" then
			giveUnitDataDrivenModifier(trigger.activator, trigger.activator, "modifier_lol_in_brush", -1)
		end
		BrushTable2[name]["entities"][trigger.activator] = true
		--print("starting updating for " .. name)

		thisEntity:SetContextThink("brush-thinker-for-" .. name, function(trigger)
				-- loops through each revealer
				for revealer, v in pairs(BrushTable2[name]["revealers"]) do 
					local largest_vr = 0
					-- This gets the largest vision the revealer should set its vision to								
					for entity, v in pairs(BrushTable2[name]["entities"]) do
						-- Checks if the entity is touching the brush
						if trigger:IsTouching(entity) then
							-- Only gets vision for things on correct team
							if entity:GetTeam() == revealer:GetTeam() then
								local entity_vr = entity:GetCurrentVisionRange()
								local d = CalcDistanceBetweenEntityOBB(entity, revealer)
								largest_vr = math.max(entity_vr - d, largest_vr)
							end
						-- Else: remove it from the table, this prevents the script from crashing when something dies in the brush
						else
							--print("entity removed")
							BrushTable2[name]["entities"][entity] = nil
						end
					end
					-- this changes vision
					revealer:SetDayTimeVisionRange(largest_vr)
					revealer:SetNightTimeVisionRange(largest_vr)
				end

				-- This will check if there are any entities remaining from your team inside the brush, if not. It stops the checking loop
				for revealer, v in pairs(BrushTable2[name]["revealers"]) do
					for entity, v in pairs(BrushTable2[name]["entities"]) do
						-- if there's an entity of the team as the revealer
						if entity:GetTeam() == revealer:GetTeam() then
							return 0.05
						end
					end
				end
				return nil
			end, 0)
	end
end
 
function BrushEnd2(trigger)
	trigger.activator:RemoveModifierByName("modifier_lol_in_brush")
	BrushTable2[trigger.caller:GetEntityIndex()]["entities"][trigger.activator] = nil
	--Say(brush, "You have entered: " .. "brush" .. trigger.caller:GetEntityIndex(), false)
end

--Stops units from getting stuck
function AntiBlockStart(trigger)
	if trigger.activator then
		trigger.activator:AddNewModifier(trigger.activator, nil, "modifier_phased", nil)
	end
end
 
function AntiBlockEnd(trigger)
	if trigger.activator then
		trigger.activator:RemoveModifierByName("modifier_phased")
	end
end
 
function giveUnitDataDrivenModifier(source, target, modifier, dur)
    --source and target should be hscript-units. The same unit can be in both source and target
    local item = CreateItem( "lol_modifiers", source, source)
    item:ApplyDataDrivenModifier(source, target, modifier, {duration=dur})
end