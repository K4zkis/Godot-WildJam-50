extends Light2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	energy1 = 0
	uplight = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
var energy1 
var uplight
func _process(delta):
	if(energy1 <= 0):
		uplight = true
	elif(energy1 >= 1): 
		uplight = false
	if(uplight):
		energy1 = energy1 + delta/2
	else:	
		energy1 = energy1 - delta/4
	self.energy = energy1	


