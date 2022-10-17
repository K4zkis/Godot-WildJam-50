extends Node2D


#const VIEW_AREA = 200
var mouse_position
onready var player = get_parent().get_node("Player")

var x_to_reach
var y_to_reach
var timer
var vector_to_reach

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	x_to_reach = (3*player.position.x + mouse_position.x)/4
	y_to_reach = (3* player.position.y + mouse_position.y)/4
	vector_to_reach = Vector2(x_to_reach,y_to_reach)
	position = position.linear_interpolate(vector_to_reach,1.6)
