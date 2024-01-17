extends CharacterState

func _frame_4():
	host.has_hyper_armor = true

func _frame_9():
	host.has_hyper_armor = false

#failsafe, in case somehow it gets cancelled or something? idk. just to be safe.
func _exit():
	host.has_hyper_armor = false
