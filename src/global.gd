extends Node


func throw_exception(message: String) -> void:
	push_error(message)

	# set_process(false)
	# set_physics_process(false)
	# set_process_input(false)
	# set_process_unhandled_input(false)
	# set_process_unhandled_key_input(false)


func ensure_not_null(value: Variant, target_name: String) -> bool:
	if value == null:
		throw_exception("%s is null" % target_name)
		return false

	return true
