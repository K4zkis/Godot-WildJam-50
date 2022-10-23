extends Area2D

onready var door_closed = get_parent().get_parent().get_node("Closed")

var latch = true
var open_icon = preload("res://Objects/door_open.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	var doorSprite = get_node("Closed")
	doorSprite.set_texture(open_icon)
	get_parent().get_parent().get_node("DoorNode/CollisionShape2D").set_disabled(true)
