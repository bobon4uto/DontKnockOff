extends Node2D

@onready var effects: Node2D = $effects
@onready var knock_timer: Timer =$Timer
@onready var scene_timer: Timer =$Timer2
@onready var door_poly =$door_poly
@onready var door_button: TouchScreenButton =$TouchScreenButton
@onready var hand =$hand
@onready var hpos = hand.position
@onready var effect_scene = preload("res://scenes/effect.tscn")
@onready var anim =$AnimationPlayer
@onready var anim2 =$AnimationPlayer2
@onready var progress =$"../../ProgressBar2"
@onready var progress2 =$"../../ProgressBar"
@onready var labelL =$"../UI/Label"
@onready var knockoff =$knockoff
@onready var knockon =$knockon
@onready var ppl =$AnimatedSprite2D
@onready var say1 =$"../UI/say1"
@onready var say2 =$"../UI/say2"
@onready var say3 =$"../UI/say3"

var honesttext =""
var lv:int = 1
var isNotDoor:bool = false
func _ready() -> void:
	set_level(1)

func _input(event):
	
	if Input.is_action_just_pressed("Knock"):
		if event is InputEventScreenTouch or event is InputEventKey:
			var effect = effect_scene.instantiate()

			var pos = Vector2(  randfn(360,100) ,randfn(640,100))
			if event is InputEventScreenTouch:
				if event.is_pressed():
					pos = event.get_position()
					
			effect.global_position = pos
			hand.global_position = pos
			effects.add_child(effect)
			
			KNOCK_KNOCK() 
			

func set_level(level):
	progress2.visible = false
	progress.visible = true
	
	knockon.visible = false
	knockoff.visible = false
	say1.visible = false
	say2.visible = false
	say3.visible = false
	door_poly.position=Vector2.ZERO
	door_poly.scale=Vector2.ONE
	isNotDoor=false
	if level == 1:
		ppl.play("man")
		honesttext= "You can't skip the dialog.
Because you will knock them off if you try!"
		progress.value=0
		progress.step=1
		progress.max_value=2
		var style = StyleBoxFlat.new()
		var basecolor= Color("ff0000") 
		style.bg_color = basecolor
		door_poly.color = basecolor
		progress.add_theme_stylebox_override("fill",style)
		#bg_color =  Color("ff0000")
		labelL.text = "Level 1
Knock on the door
(you can use spacebar or tap/click on it)"
		say1.text = "Hello, stranger, I'm a png-man!"
		say2.text = "What? I am sure I am an PNG. "
		say3.text = "Oh no.. my transparent background! it's fake!!! I need to see my doctor! "



	elif level == 2:
		ppl.play("hand")
		honesttext= "That's your fellow left hand! 
it's complaining about something."
		progress.value=0
		progress.step=1
		progress.max_value=5
		var style = StyleBoxFlat.new()
		var basecolor = Color("964B00")
		style.bg_color = basecolor
		door_poly.color = basecolor
		progress.add_theme_stylebox_override("fill",style)
		progress2.add_theme_stylebox_override("fill",style)
		labelL.text = "Level 2
keep Knocking on the door!"
		say1.text = "*Hand noises*"
		say2.text = "*claping*"
		say3.text = "*high five*"

	elif level == 3:
		ppl.play("arch")
		honesttext= "That's a door, I think?"
		progress.value=0
		progress.step=1
		progress.max_value=3
		var style = StyleBoxFlat.new()
		var basecolor = Color("ffc40c")
		style.bg_color = basecolor
		door_poly.color = basecolor
		progress.add_theme_stylebox_override("fill",style)
		progress2.add_theme_stylebox_override("fill",style)
		#bg_color =  Color("ff0000")
		labelL.text = "Level 3
Sometimes knocking once isn't enough. double tapping might help."
		say1.text = ""
		say2.text = "Oh, I havent noticed you. I am an arch that holds that door."
		say3.text = "btw did I mention I am an arch? yeah, btw I'm an arch btw."

	elif level == 4:
		ppl.play("snail")
		honesttext= "A snail."
		progress.value=0
		progress.step=1
		progress.max_value=3
		var style = StyleBoxFlat.new()
		var basecolor = Color("dfff00")
		style.bg_color = basecolor
		door_poly.color = basecolor
		progress.add_theme_stylebox_override("fill",style)
		progress2.add_theme_stylebox_override("fill",style)
		labelL.text = "Level 4
Sometimes you have to take your time..."
		say1.text = "Hhhhheeeee"
		say2.text = "llllllllll"
		say3.text = "oooooooooo"


func _on_timer_timeout() -> void:
	hand.position=hpos
func door_tap():
	if progress.value < progress.max_value:
		progress.value +=1

func KNOCK_ON():
	lv+=1
	labelL.text = honesttext
	progress2.visible = true
	progress.visible = false
	anim.play("open")
	anim2.play("talk")
	knockon.visible = true
	scene_timer.start(13.0)
	
	pass
func KNOCK_OFF():
	progress.value=0
	door_button.visible = false
	knockoff.visible = true
	anim2.play("KNOCKOFF")
	knock_timer.start(3.0) 
	scene_timer.start(3.0)
	lv-=1

	
	pass
func KNOCK_KNOCK():
	if isNotDoor:
		KNOCK_OFF()
		return
	if lv == 1:
		door_tap()
	elif lv == 2:
		door_tap()
	elif lv == 3:
		if knock_timer.time_left > 0 :
			door_tap()
	elif lv == 4:
		if knock_timer.time_left > 0 :
			pass
		else:
			door_tap()
	knock_timer.start(1.0)  
	if progress.value==progress.max_value:
		isNotDoor=true
		KNOCK_ON()



func _on_timer_2_timeout() -> void:
	progress2.visible = false
	progress.visible = true
	door_button.visible = true
	set_level(lv)
