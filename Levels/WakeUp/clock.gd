extends Sprite2D
class_name Clock

signal clock_clicked

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		clock_clicked.emit()
		queue_free()
	pass
