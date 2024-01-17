extends "res://characters/states/Landing.gd"

onready var hitbox = $Hitbox

const SPEED_HITBOX_ACTIVATION = "8.0"
const SPEED_HITBOX_RATIO = "1.0"
const BASE_DAMAGE = 10
const BASE_HITSTUN = 15
const GROUND_POUND_LAG = 8

var has_hitbox = false

func _frame_0():
	var prev:CharacterState = _previous_state()
	var speed = host.last_aerial_vel.y
	#has hitbox = true if not in tumble
	has_hitbox = prev.busy_interrupt_type != BusyInterrupt.Hurt and not (prev is CharacterHurtState) and fixed.gt(speed, SPEED_HITBOX_ACTIVATION)
	set_lag(null if not has_hitbox else GROUND_POUND_LAG)
	hitbox.hits_vs_grounded = has_hitbox
	
	var ratio = fixed.div(speed, SPEED_HITBOX_RATIO)
	var damage = fixed.round(fixed.mul(ratio, str(BASE_DAMAGE)))

	damage = BASE_DAMAGE
	hitbox.damage = damage
	
	var hitstun = BASE_HITSTUN
	
	hitbox.hitstun_ticks = hitstun
	hitbox.combo_hitstun_ticks = hitstun - 5
	
