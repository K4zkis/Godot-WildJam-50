extends Control

var hearts = 5 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var label = $Label

func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	var sprites = get_children()
	for i in sprites:
		if(i.get_index() +1 > hearts):
			i.hide()
	
func set_max_hearts(value):
	max_hearts = max(value,1)
	
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
