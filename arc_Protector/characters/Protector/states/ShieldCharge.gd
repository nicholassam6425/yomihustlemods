extends CharacterState

export var moving = false;
export var prev_dmg_reduc = "-1.0";
const SPEED_LIMIT = "10.0"

const SPEED = "1.0"

func _tick():
	if moving:
		host.apply_force_relative(SPEED, "0")
	host.apply_forces_no_limit()
	host.limit_speed(SPEED_LIMIT)
	
func _frame_9():
	moving = true;
	host.has_hyper_armor = true
	#gain additional 20% damage reduction, up to 50% total damage reduction.
	if fixed.ge(str(host.damage_taken_modifier), "0.7"):
		fixed.sub(str(host.damage_taken_modifier), "0.2")
	elif fixed.gt(str(host.damage_taken_modifier), "0.5"):
		prev_dmg_reduc = str(host.damage_taken_modifier)
		host.damage_taken_modifier = "0.5"

# when the move finishes, lost hyper armor and damage reduction
func _exit():
	host.has_hyper_armor = false
	if fixed.ge(prev_dmg_reduc, "0"):
		host.damage_taken_modifier = prev_dmg_reduc
	else:
		fixed.add(str(host.damage_taken_modifier), "0.2")
