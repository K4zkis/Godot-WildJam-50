extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var MAX_SPEED = 25
export var path_to_player := NodePath()
var velocity := Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player := get_node(path_to_player)
onready var _agent : NavigationAgent2D = $NavigationAgent2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_pathfinding()
	get_node("CollisionShape2D").position.x += 10
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player.position.x < self.position.x):
		get_node("Sprite").flip_h = false
		get_node("Sprite").offset.x = 10
	else:
		get_node("Sprite").flip_h = true
		get_node("Sprite").offset.x = -10
		
	var direction := global_position.direction_to(_agent.get_next_location())
	var desired_velocity = direction * MAX_SPEED
	var steering = (desired_velocity - velocity)*delta*4.0
	velocity += steering
	_agent.set_velocity(steering)
	move(velocity)
	_update_pathfinding()
	
func _update_pathfinding()-> void:
	_agent.set_target_location(player.global_position)
	
func move(velocity: Vector2)-> void:
	velocity = move_and_slide(velocity)
