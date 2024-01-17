extends PlayerExtra


onready var fast_fall_button = $"%FastFallButton"

func _ready():
	fast_fall_button.connect("toggled", self, "_on_fast_fall_button_toggled")


func _on_fast_fall_button_toggled(on):
	emit_signal("data_changed")

func reset():
	var is_hurt = fighter.current_state() != CharacterHurtState
	fast_fall_button.set_pressed_no_signal(fighter.fast_falling and is_hurt)

func show_options():
	fast_fall_button.hide()
	fast_fall_button.set_pressed_no_signal(fighter.fast_falling)

	if not fighter.is_grounded():
		fast_fall_button.show()

func get_extra():
	var extra = {
		"fast_fall":fast_fall_button.pressed, 
	}
	return extra
