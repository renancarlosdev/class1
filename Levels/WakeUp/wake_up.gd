extends Node2D

#@export var clock: Clock
@onready var point_light_2d: PointLight2D = $CanvasLayer2/PointLight2D
const CLOCK = preload("res://Levels/WakeUp/clock.tscn")

const NEOKI_MAN = preload("res://Levels/WakeUp/bedroom/neoki_man.png")
const SUIMIN_MAN = preload("res://Levels/WakeUp/bedroom/suimin_man.png")
const NEOKI_BOY_SAWAYAKA = preload("res://Levels/WakeUp/bedroom/neoki_boy_sawayaka.png")


var clock_click_count = 0

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



func _on_clock_timer_timeout() -> void:	
	var new_clock = CLOCK.instantiate()
	new_clock.clock_clicked.connect(on_clock_clicked)
	var rand_x = randi_range(80,1150)
	var rand_y = randi_range(80,600)
	new_clock.position = Vector2(rand_x,rand_y)
	add_child(new_clock)
		
	

		
