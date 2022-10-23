extends KinematicBody2D


export (int) var MAX_SPEED_SPIDER = 25
export var path_to_player := NodePath()
export var health = 100

onready var player := get_parent().get_parent().get_node("Player")
onready var _agent : NavigationAgent2D = $NavigationAgent2D
onready var _timer: Timer = $Timer
onready var stats = $Stats
# Called when the node enters the scene tree for the first time.
var velocity := Vector2.ZERO
var state = IDLE
var spider_position = self.position
var original_position = spider_position
var attack_radius = 400

enum {
	ATTACK
	IDLE
}
func _ready():
	if(player==null):
		return
	_update_pathfinding()
	_timer.connect("timeout", self, "_update_pathfinding")
	_agent.connect("velocity_computed", self, "move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("fall_in trap"):
#		queue_free()
	
	var distance = spider_position.distance_to(player.position)
	
	if distance <= attack_radius:
		state = ATTACK
	elif distance > attack_radius:
		state = IDLE
	
	match state:
		ATTACK:
			if _agent.is_navigation_finished():
				return 
			var direction := global_position.direction_to(_agent.get_next_location())
			var desired_velocity = direction * MAX_SPEED_SPIDER
			var steering = (desired_velocity - velocity)*delta*4.0
			velocity += steering
			_agent.set_velocity(velocity)
			
			#if player:
				#var direction = (player.position - position).normalized()
				#direction = move_and_slide(direction * SPIDER_SPEED)
			
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				var object = collision.collider
				if object.is_in_group("player"):
					object.apply_damage()
		IDLE:
			if spider_position != original_position:
				global_transform.origin = original_position
			else:
				pass
				

func _update_pathfinding()-> void:
	_agent.set_target_location(player.global_position)
	
func move(velocity: Vector2)-> void:
	velocity = move_and_slide(velocity)
	
#potential stats
func getKnocked(velocity: Vector2)-> void:
	velocity = move_and_slide(velocity)



func hit(var knockback):
	self.getKnocked(knockback)
	health= health -1
	if(health <=0):
		queue_free()
		
