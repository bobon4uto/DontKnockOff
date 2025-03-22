extends Node2D

@onready var effects: Node2D = $effects
@onready var knock_timer: Timer =$Timer
@onready var door_button: TouchScreenButton =$TouchScreenButton

@onready var effect_scene = preload("res://scenes/effect.tscn")


func _input(event):
	
	if Input.is_action_just_pressed("Knock"):
		if event is InputEventScreenTouch or event is InputEventKey:
			var effect = effect_scene.instantiate()

			var pos = Vector2(  randfn(360,100) ,randfn(640,100))
			if event is InputEventScreenTouch:
				if event.is_pressed():
					pos = event.get_position()
					
			effect.global_position = pos
			effects.add_child(effect)
			
			KNOCK_KNOCK() 

func _on_timer_timeout() -> void:
	pass

func KNOCK_KNOCK():
	
	knock_timer.start()  
