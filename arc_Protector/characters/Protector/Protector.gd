extends Fighter

const FAST_FALL_SPEED = "10" #how fast does protector fast fall, wizard fast fall = 7

var fast_falling = false #default fast falling state
var fast_fall_landing = false #fast fall landing state, triggers landing shockwave

func _ready():
	pass

# change gravity function to check for fast falling state
func apply_grav():
	if fast_falling:
		.apply_grav_custom(FAST_FALL_SPEED, FAST_FALL_SPEED)
	else:
		.apply_grav()
func apply_grav_fast_fall():
	move_directly("0", FAST_FALL_SPEED)

# when state changes, check if its hurt state. if yes, then turn off fast falling
func on_state_started(state):
	.on_state_started(state)
	if state.busy_interrupt_type == CharacterState.BusyInterrupt.Hurt:
		fast_falling = false

func tick():
	.tick()
	# if we're not in a hurt state and grounded, turn off fast fall and turn on fast fall landing
	if hitlag_ticks <= 0:
		if is_grounded():

			if fast_falling:
				fast_fall_landing = true
			fast_falling = false
		else :
			fast_fall_landing = false
		if fast_falling:
			apply_grav_fast_fall()

func process_extra(extra):
	.process_extra(extra)

	if can_fast_fall():
		if extra.has("fast_fall"):
			if extra["fast_fall"]:
				if extra["fast_fall"] and not fast_falling:
					play_sound("FastFall")
					set_vel(get_vel().x, FAST_FALL_SPEED)
				fast_falling = extra["fast_fall"]
		else :
			fast_falling = false
	else :
		fast_falling = false

func can_fast_fall():
	return not is_grounded()
