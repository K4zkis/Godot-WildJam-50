extends KinematicBody2D

export (int) var MAX_SPEED = 80
export (int) var KNOCKBACK_SPEED =400
export (int) var ACCELERATION = 20
export (int) var FRICTION = 50
export (int) var HOLD_SPEED = 40
export (bool) var HOLDING_ITEM = false
export (bool) var STUN_ACTIVE = false
export (float) var STUN_TIME = 0.7
export (float) var INVINCIBILITY_DURATION = 1.1
var velocity = Vector2()
var counter = 0

enum {
	Garlic_1,
	Garlic_2,
	Garlic_3,
	Garlic_4,
	Garlic_5,
	Player_state
}


var state = Player_state



onready var timer = get_parent().get_parent().get_node("Timer")
onready var stats = PlayerStats
onready var hurtbox = $Hurtbox

func _ready():
	stats.connect("no_health", self, "queue_free")
	timer.set_one_shot(STUN_TIME)
	
	
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		get_node("Raven_Sprite").set_flip_h(false)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		get_node("Raven_Sprite").set_flip_h(true)
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

func _physics_process(_delta):
	
	match state:
		Garlic_1:
			pass
		Garlic_2:
			pass
		Garlic_3:
			pass
		Garlic_4:
			pass
		Garlic_5:
			pass
		Player_state:
			pass
	
	
	
	if STUN_ACTIVE == false:
		get_input()
		if HOLDING_ITEM:
			velocity = velocity.normalized() * HOLD_SPEED
		else:
			velocity = velocity.normalized() * MAX_SPEED
	else:
		var knockback_direction = Vector2()
		knockback_direction = (self.global_transform.origin - get_parent().get_node("Boss").global_transform.origin).normalized()
		apply_knockback(knockback_direction,_delta)
		
	
	if velocity == Vector2(0,0):
		$Raven_Sprite.animation = "Idle"
	else:
		$Raven_Sprite.animation = "Walking"
	
	velocity = move_and_slide(velocity)
	
	
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
	
	
func apply_frozen_ground():
	#friction
	pass
	
	
func apply_damage():
	# apply damage in case of
	# interaction with boss
	# contact with the wall at certain speed
	# contact with spider attack
	pass
	
	
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
	print (stats.health)


func _on_Stats_no_health():
	print("Player Died")
	pass # Replace with function body.
