class_name GamePlayer

enum Id { X, O }

var _id: Id


func _init(id: Id = Id.X) -> void:
	_id = id


func _to_string() -> String:
	return "GamePlayer(id = %s)" % Id.keys()[_id]


func get_value() -> Id:
	return _id


func is_x() -> bool:
	return _id == Id.X


func is_o() -> bool:
	return _id == Id.O


func next() -> GamePlayer:
	return GamePlayer.new((_id + 1) % 2)
