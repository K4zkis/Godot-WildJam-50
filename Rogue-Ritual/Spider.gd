extends KinematicBody2D

export (int) var SPIDER_SPEED = 20
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	if player:
		var direction = (player.position - position).normalized()
		direction = move_and_slide(direction * SPIDER_SPEED)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var object = collision.collider
		if object.is_in_group("player"):
			object.apply_damage()
