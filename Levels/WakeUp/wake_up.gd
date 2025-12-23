extends Node2D

#@export var clock: Clock
@onready var point_light_2d: PointLight2D = $CanvasLayer2/PointLight2D
#@onready var bell_fx_music: Sprite2D = $Bell2/BellFxMusic


const CLOCK = preload("res://Levels/WakeUp/clock.tscn")
const NEOKI_MAN = preload("res://Levels/WakeUp/Assets/neoki_man.png")
const SUIMIN_MAN = preload("res://Levels/WakeUp/Assets/suimin_man.png")
const NEOKI_BOY_SAWAYAKA = preload("res://Levels/WakeUp/Assets/neoki_boy_sawayaka.png")
const BELL_FX_MUSIC = preload("res://Levels/WakeUp/bell_fx_music.tscn")


var clock_click_count = 0
var bell_click_count = 0
var eye_count = 1

func _ready() -> void:
	pass



func on_clock_clicked():
	clock_click_count += 1
	point_light_2d.scale = point_light_2d.scale + Vector2(1.0,1.0)
	
	if clock_click_count >= 5:
		$ClockTimer.stop()
		$CanvasLayer2/CanvasModulate.hide()
		point_light_2d.hide()
		
		#add turn on light (click) sound
		#change image + yawn sound
		$CanvasLayer2/Person.texture = NEOKI_MAN
		$Bell2.show()
		$Eyes.show()
		$CanvasLayer/Label.text = "GET UP"



func _on_clock_timer_timeout() -> void:	
	var new_clock = CLOCK.instantiate()
	new_clock.clock_clicked.connect(on_clock_clicked)
	var rand_x = randi_range(80,1150)
	var rand_y = randi_range(80,600)
	new_clock.position = Vector2(rand_x,rand_y)
	add_child(new_clock)
		
	

		


func _on_bell_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		bell_click_count += 1
		#ting sound
		#var new_node2d_parent = Node2D.new()
		var new_fx_music = BELL_FX_MUSIC.instantiate()
		#$Bell2.add_child(new_node2d_parent)
		$Bell2.add_child(new_fx_music)
		#new_node2d_parent.add_child(new_fx_music)
		#new_fx_music.get_child(0).play("fx_music")
		
	if bell_click_count == 5 && eye_count < 4:
		eye_count += 1
		bell_click_count = 0
		var tween = get_tree().create_tween()
		tween.tween_property($Eyes,"position",$Eyes.position+Vector2(0,-200),0.5)\
		.set_ease(Tween.EASE_OUT)
		get_node("Eyes/Eye"+str(eye_count-1)).self_modulate = Color(1.0, 1.0, 1.0, 0.502)
		await tween.finished
		get_node("Eyes/Eye"+str(eye_count)).self_modulate = Color(1.0, 1.0, 1.0, 1.0)
		#get_node("Eyes/Eye"+str(eye_count-1)).self_modulate = Color(1.0, 1.0, 1.0, 0.502)
		
		if eye_count == 4:
			$CanvasLayer2/Person.texture = NEOKI_BOY_SAWAYAKA
			await get_tree().create_timer(1).timeout
			$Bell2.hide()
			$Eyes.hide()
			$ButtonCook.show()
			$ButtonBrushT.show()
			$CanvasLayer/Label.text = "COOK OR BRUSH THE TEETH"
