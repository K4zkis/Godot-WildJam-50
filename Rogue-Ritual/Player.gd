extends "res://Base_state.gd"

export (bool) var STUN_ACTIVE = false
export (float) var STUN_TIME = 0.7
export (int) var KNOCKBACK_SPEED =400

onready var timer = get_parent().get_parent().get_node("Timer")

var counter = 0
var Garlic_icon = preload("res://Switch_to_objects/Controlled_Garlic.tscn")


func _ready():
	timer.set_one_shot(STUN_TIME)
	PlayerStats.set_health(5)

func _physics_process(_delta):
	
	if STUN_ACTIVE == false:
		get_input()
#		Legacy Code:
#		if HOLDING_ITEM:
#			velocity = velocity.normalized() * HOLD_SPEED
#		else:
		velocity = velocity.normalized() * MAX_SPEED
	else:
		var knockback_direction = Vector2()
		knockback_direction = (self.global_transform.origin - get_parent().get_node("Boss").global_transform.origin).normalized()
		apply_knockback(knockback_direction,_delta)
	
	match state: 
		Player_state:
			for index in get_slide_count():
				var collision = get_slide_collision(index)
				if collision.collider.name.begins_with("Boss"):
					print ("collided with ", collision.collider.name)
					STUN_ACTIVE = true


func apply_knockback(direction,_delta):
	#this doesn't work yet
	if counter == 0:
		timer.start()
		print ("Timer is started")
	else:
		#change the speed with each frame "delta" through decrease_speed_bezier() function
		velocity = decrease_speed_bezier(_delta,direction,counter)
	counter +=1
	
func decrease_speed_bezier(_delta,direction,count):
	#this is in progress
	var new_speed=KNOCKBACK_SPEED/count
	var remaining = timer.get_time_left()
	#the max time we have is STUN_TIME
	if remaining < STUN_TIME and remaining > 0.5*STUN_TIME:
		#first part decreses linear
		pass
	if remaining < 0.5*STUN_TIME and remaining > 0.2*STUN_TIME:
		pass
	else:
		#last part is linearly interpolated
		pass
	#new_speed = move_toward(new_speed,0,0.8)
	return direction*new_speed



func Timer_timeout():
	STUN_ACTIVE=false
	counter = 0
	print (" Stun is deactivated and counter reset")


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(INVINCIBILITY_DURATION)


func _on_Stats_no_health():
	get_tree().change_scene("res://Menu.tscn")


func _on_First_found_object_object_pressed():
	used_Sprite.set_visible(false)
	used_Sprite = get_node("Controlled_Garlic")
	used_Sprite.set_visible(true)
	get_parent().get_parent().get_node("Object_to collect 1").queue_free()
	state = Garlic_1
	



func _place_on_pentagramm():
	pass
