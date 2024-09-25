class_name CellStatusCollection

var _elements: Array[CellStatus] = []


func append(status: CellStatus) -> void:
	_elements.append(status)


func _get_at(index: int) -> CellStatus:
	return _elements[index]


func _is_empty() -> bool:
	return _elements.is_empty()


func _are_all_same_and_not_empty() -> bool:
	if _elements.is_empty():
		return false

	return _elements.all(
		func(cell_status: CellStatus) -> bool: return cell_status.is_equal_and_not_empty(
			_elements[0]
		)
	)


func get_winner() -> CellStatus:
	return _elements[0] if _are_all_same_and_not_empty() else CellStatus.empty
