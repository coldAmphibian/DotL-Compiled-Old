function OnStartTouch(trigger)
	print(trigger.activator)
	print(trigger.caller)
	if trigger.activator
		trigger.activator:AddNewModifier(trigger.activator, nil, "MODIFIER_STATE_NO_UNIT_COLLISION", nil)
	end
end

function OnEndTouch(trigger)
	print(trigger.activator)
	print(trigger.caller)
	if trigger.activator then
		trigger.activator:RemoveModifierByName("MODIFIER_STATE_NO_UNIT_COLLISION")
		end

end
