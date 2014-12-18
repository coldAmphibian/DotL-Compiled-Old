
--This handles walking into brushes
function BrushAStart(trigger)
	giveUnitDataDrivenModifier(trigger.activator, trigger.activator, "modifier_lol_in_brush", -1)
	--SetContextThink( "myThinker", function() print("Hello") end, 2.0 )
	while trigger.activator:HasModifier("modifier_lol_in_brush") do
		local x = trigger.activator:GetAbsOrigin()[1]
		local y = trigger.activator:GetAbsOrigin()[2]
		local z = trigger.activator:GetAbsOrigin()[3]

		--print("x"..trigger.activator:GetAbsOrigin()[1])
		--print("y"..trigger.activator:GetAbsOrigin()[2])
		--print("z"..trigger.activator:GetAbsOrigin()[3])
		--print(trigger.activator:GetUnitName())
		--SetContextThink( "myThinker", function() print("Hello") end, 2.0 )
		--wait(100)
	end
end

function BrushAEnd(trigger)
	trigger.activator:RemoveModifierByName("modifier_lol_in_brush")
	print("exited")
	--trigger.activator:SetDayTimeVisionRange((trigger.activator:GetDayTimeVisionRange() + 1000))
end

function BrushBStart(trigger)
	local units_in_brush
	print("omg")
	giveUnitDataDrivenModifier(trigger.activator, trigger.activator, "modifier_lol_in_brush", -1)
	--trigger.activator:AddNewModifier(trigger.activator, nil, "lol_inside_brush", nil)
end

function BrushBEnd(trigger)
	trigger.activator:RemoveModifierByName("modifier_lol_in_brush")
end

function BrushVision(args)
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

function BushStart(trigger)
	if trigger.activator then
		trigger.activator:AddNewModifier(trigger.activator, nil, "modifier_invisible", nil)
	end
end

function BushEnd(trigger)
	if trigger.activator then
		trigger.activator:RemoveModifierByName("modifier_invisible")
	end
end

function giveUnitDataDrivenModifier(source, target, modifier, dur)
    --source and target should be hscript-units. The same unit can be in both source and target
    local item = CreateItem( "lol_modifiers", source, source)
    item:ApplyDataDrivenModifier(source, target, modifier, {duration=dur})
end