extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move = Vector2(0,0) #direction
var speed = 1.2

func _set_move(vec):
	move = vec

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
	if(speed >0):
		speed = speed * 0.98
		
	if(speed <= 0.3):
		queue_free()
	self.modulate.a = speed
	
func move():
	move_and_slide(move*speed,Vector2(0,0),false,4,0.785398,false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("enemies"):
			if(index == 0): #prevents multiple hits
				collision.collider._is_hit()
		queue_free()	


func _on_Area2D_area_entered(area):
	if area.get_parent().has_method("hit"):
		area.get_parent().hit((area.global_position -self.global_position).normalized()*100)
		queue_free()
