extends Particles2D

export var path_to_player := NodePath()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player := get_node(path_to_player)

# Called when the node enters the scene tree for the first time.
func _ready():
	local_coords =false

var pointing
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("leftmouse")):
		emitting = true
		position = player.position
		pointing = (get_global_mouse_position() - player.global_position).normalized()
		self.rotation = pointing.angle()
	else:
		emitting = false
