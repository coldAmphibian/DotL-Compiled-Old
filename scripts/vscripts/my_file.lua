function OnStartTouch(trigger)
	if trigger.activator then
		trigger.activator:AddNewModifier(trigger.activator, nil, "modifier_phased", nil)

		end
	end

function OnEndTouch(trigger)
	if trigger.activator then
		trigger.activator:RemoveModifierByName("modifier_phased")

		end
	end