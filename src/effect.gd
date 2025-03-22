extends Node2D
@onready var life_timer: Timer =$Timer
@onready var anim: AnimationPlayer =$AnimationPlayer
func _ready():
	rotation = randfn(0,2*3.14)
	life_timer.start(randfn(1.0,0.25))
	anim.play("pop")
	
	
func _on_timer_timeout() -> void:
	queue_free()
