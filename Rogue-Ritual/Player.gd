extends KinematicBody2D

export (int) var MAX_SPEED = 250
export (int) var ACCELERATION = 20
export (int) var FRICTION = 20
export (int) var HOLD_SPEED = 150
export (bool) var HOLDING_ITEM = false

var velocity = Vector2()

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
	get_input()
	if velocity == Vector2(0,0):
		$Raven_Sprite.animation = "Idle"
	else:
		$Raven_Sprite.animation = "Walking"
	if HOLDING_ITEM:
		velocity = velocity.normalized() * HOLD_SPEED
	else:
		velocity = velocity.normalized() * MAX_SPEED
	velocity = move_and_slide(velocity)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.name.begins_with("Boss"):
			print ("collided with", collision.collider.name)
			apply_knockback()
	


func apply_knockback():
	pass
func apply_frozen_ground():
	#friction
	pass
func apply_damage():
	# apply damage in case of
	# interaction with boss
	# contact with the wall at certain speed
	# contact with spider attack
	pass
