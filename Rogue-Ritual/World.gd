extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/PlayerStats").garlics = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_node("/root/PlayerStats").garlics == 5):
		get_tree().change_scene("res://Credits.tscn")
