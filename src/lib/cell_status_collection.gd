class_name CellStatusCollection

var _statuses: Array[CellStatus]


func _init() -> void:
	_statuses = []


func append(status: CellStatus) -> void:
	_statuses.append(status)


func _get_at(index: int) -> CellStatus:
	return _statuses[index]


func _is_empty() -> bool:
	return _statuses.is_empty()


func _are_all_same_and_not_empty() -> bool:
	if _statuses.is_empty():
		return false

	return _statuses.all(
		func(cell_status: CellStatus) -> bool: return cell_status.is_equal_and_not_empty(
			_statuses[0]
		)
	)


func get_winner() -> CellStatus:
	return _statuses[0] if _are_all_same_and_not_empty() else CellStatus.empty
