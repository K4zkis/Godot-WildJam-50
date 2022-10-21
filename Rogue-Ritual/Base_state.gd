extends KinematicBody2D


export (int) var MAX_SPEED = 80

export (int) var ACCELERATION = 20
export (int) var FRICTION = 50
#export (int) var HOLD_SPEED = 40
#export (bool) var HOLDING_ITEM = false
export (float) var INVINCIBILITY_DURATION = 1.1

onready var stats = PlayerStats
onready var hurtbox = $Hurtbox

var velocity = Vector2()
var state = Player_state
onready var used_Sprite = get_node("Raven_Sprite")

enum {
	Garlic_1,
	Garlic_2,
	Garlic_3,
	Garlic_4,
	Garlic_5,
	Player_state
}



func _ready():
	stats.connect("no_health", self, "_on_Stats_no_health")
	
	
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		used_Sprite.set_flip_h(false)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		used_Sprite.set_flip_h(true)
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

func _physics_process(_delta):
		
	if velocity == Vector2(0,0):
		used_Sprite.animation = "Idle"
	else:
		used_Sprite.animation = "Walking"
	
	velocity = move_and_slide(velocity)
		
func apply_frozen_ground():
	#friction
	pass
	
	
func apply_damage():
	# apply damage in case of
	# interaction with boss
	# contact with the wall at certain speed
	# contact with spider attack
	pass
	
	

