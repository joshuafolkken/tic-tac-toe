class_name GamePlayer

enum Id { X, O }

var _id: Id


func _init(id: Id = Id.X) -> void:
	_id = id


func _to_string() -> String:
	return "GamePlayer(id=%d)" % [_id]


func next() -> GamePlayer:
	return GamePlayer.new((_id + 1) % 2)


func get_value() -> Id:
	return _id


func is_x() -> bool:
	return _id == Id.X


func is_o() -> bool:
	return _id == Id.O

# func _is_equal(other: Variant) -> bool:
# 	print("_is_equal: %s == %s" % [self, other])
# 	return other is GamePlayer and _id == other._id

# func _equals(other: Variant) -> bool:
# 	print("equal: %s == %s" % [self, other])
# 	return other is GamePlayer and _id == other._id

# func is_equal(other: Variant) -> bool:
# 	print("equal: %s == %s" % [self, other])
# 	return other is GamePlayer and _id == other._id

# func _eq(other: Variant) -> bool:
# 	print("_eq: %s == %s" % [self, other])
# 	return other is GamePlayer and _id == other._id

# func eq(other: Variant) -> bool:
# 	print("eq: %s == %s" % [self, other])
# 	return other is GamePlayer and _id == other._id
