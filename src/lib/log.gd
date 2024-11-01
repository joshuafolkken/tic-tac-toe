class_name Log

static var _last_log_time_ms: float = 0.0


static func _print(category_name: String, message: String) -> void:
	var time_dict := Time.get_datetime_dict_from_system()
	var unix_time := Time.get_unix_time_from_system()
	var current_time_ms := unix_time
	var msec := int(fmod(unix_time * 1000, 1000))

	var time_diff := 0.0

	if _last_log_time_ms > 0.0:
		time_diff = current_time_ms - _last_log_time_ms

	_last_log_time_ms = current_time_ms

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

	var formatted_diff_ms := "+%0.3fms" % time_diff

	prints(formatted_time, formatted_diff_ms, "[%s]" % category_name, message)


static func d(message: String) -> void:
	_print("DEBUG", message)
