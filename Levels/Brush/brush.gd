extends Node2D

@onready var hand_brush: Sprite2D = $HandBrush
@onready var brush_area_2d: Area2D = $HandBrush/BrushArea2D

var original_pos
var distance_moved = Vector2(0,0)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	original_pos = brush_area_2d.global_position

func _process(_delta: float) -> void:
	hand_brush.global_position = get_global_mouse_position()
	
	if brush_area_2d.has_overlapping_areas():
		var pos_diff = abs(floor(hand_brush.global_position) - floor(original_pos))
		#print(str(pos_diff))
		if floor(hand_brush.global_position) != floor(original_pos):
			#print(str(pos_diff))
			distance_moved += pos_diff
			#print(str(distance_moved))
			original_pos = hand_brush.global_position

	
	if distance_moved.x  > 80 || + distance_moved.y > 80:#increase?
		print("moved")
		distance_moved = Vector2.ZERO
