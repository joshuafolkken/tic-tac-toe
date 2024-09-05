class_name InitTest
extends BaseTest


func is_ready() -> void:
	assert_object(_scene._board).is_not_null()
	assert_object(_scene._position_history).is_not_null()
	assert_object(_scene._current_player).is_not_null()

	# is_reset_buttons
	assert_bool(_scene._status_label.visible).is_false()
	is_buttons_enabled()


func test_ready() -> void:
	is_ready()
