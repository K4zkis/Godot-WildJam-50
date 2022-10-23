extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var flame = load("res://flame.tscn")

var direction
var mana = 400
var lockedAttack =false

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("leftmouse") and randi() %10 >6 and !lockedAttack):
		var one = flame.instance()
		var stage = get_tree().current_scene
		stage.add_child(one)
		one.position = get_parent().global_position
		direction = (get_global_mouse_position() - get_parent().global_position + Vector2(rand_range(-20, 20), rand_range(-20, 20)).normalized()*20).normalized() *80
		one._set_move(direction)
		mana= mana- 10
	mana = mana +1
	if(mana <20 and !lockedAttack):
		get_parent().modulate = Color(0.5,1,1)
		lockedAttack=true
	if(mana>= 360):
		lockedAttack=false
		get_parent().modulate = Color(1,1,1)
	if(get_parent().used_Sprite != get_parent().get_node("Raven_Sprite")):
		lockedAttack =true	
