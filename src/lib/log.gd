class_name Log


static func _print(category_name: String, message: String) -> void:
	var time_dict := Time.get_datetime_dict_from_system()
	var msec := Time.get_ticks_msec() % 1000
	var formatted_time := (
		"%04d-%02d-%02d %02d:%02d:%02d.%03d"
		% [
			time_dict.year,
			time_dict.month,
			time_dict.day,
			time_dict.hour,
			time_dict.minute,
			time_dict.second,
			msec,
		]
	)
	prints(formatted_time, "[%s]" % category_name, message)


static func d(message: String) -> void:
	_print("DEBUG", message)
