extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	energy = 0
	uplight = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
var energy
var uplight
func _process(delta):
	if(energy <= 0):
		uplight = true
	elif(energy >= 1): 
		uplight = false
	if(uplight):
		energy = energy + delta
	else:	
		energy = energy - delta/2
	get_node("Light2D").energy = energy	
	for i in get_node("Garlics").get_children():
		if(i.get_index() +1 > get_node("/root/PlayerStats").garlics):
			i.hide()
		else:
			i.show()

