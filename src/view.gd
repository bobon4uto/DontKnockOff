extends Node2D

@onready var effects: Node2D = $effects
@onready var knock_timer: Timer =$Timer
func _process(delta):
	if Input.is_action_just_pressed("Knock"):
		KNOCK_KNOCK() 
	

func _on_timer_timeout() -> void:
	effects.visible = false

func KNOCK_KNOCK():
	effects.visible = true
	knock_timer.start()  

func _on_texture_button_pressed() -> void:
	KNOCK_KNOCK()
