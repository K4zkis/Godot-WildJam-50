extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position =  get_parent().get_node("YSort/Player").position + (get_parent().get_node("Player_Camera_mouse").position - get_parent().get_node("YSort/Player").position).normalized()*  50
	self.rotation = ( get_parent().get_node("Player_Camera_mouse").position - get_parent().get_node("YSort/Player").position).angle()
