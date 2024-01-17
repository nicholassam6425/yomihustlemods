extends "res://characters/states/Dash.gd"

func _frame_1():
	if dir_x < 0:
		MAX_SPEED_RATIO = "1.0"
		host.add_penalty(back_penalty)
		host.reset_momentum()
	else :
		MAX_SPEED_RATIO = "1.25"
		beats_backdash = true

		if not charged and host.combo_count > 0:
			starting_iasa_at = MIN_IASA
		else :
			starting_iasa_at = Utils.int_max(fixed.round(fixed.add(fixed.mul(dist_ratio, str(MAX_IASA - MIN_IASA)), str(MIN_IASA))), 1)

		iasa_at = starting_iasa_at
	if startup_lag != 0:
		return 
	var dash_force = str(dir_x * dash_speed)
	if _previous_state_name() == "ChargeDash" or data and data.has("charged"):
		dash_force = fixed.mul(dash_force, "2")
		charged = true
		data["charged"] = true
	host.apply_force_relative(fixed.mul(dash_force, fixed.add(fixed.mul(dist_ratio, fixed.sub(MAX_SPEED_RATIO, MIN_SPEED_RATIO)), MIN_SPEED_RATIO)), "0")
	if spawn_particle:
		spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(dir_x, 0))
	host.apply_grav()
