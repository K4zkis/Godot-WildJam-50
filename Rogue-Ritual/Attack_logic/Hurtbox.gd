extends Area2D

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

onready var timer = $Timer


func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	get_parent().get_node("Raven_Sprite").modulate = Color(1,0,0)

func _on_Timer_timeout():
	self.invincible = false # Replace with function body.
	get_parent().get_node("Raven_Sprite").modulate = Color(1,1,1)


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)


func _on_Hurtbox_invincibility_ended():
	monitorable = true


func _on_Pentagram_node_area_entered(area):
	if(get_parent().state == 0):
		get_parent().state = 5
		get_parent().used_Sprite.set_visible(false)
		get_parent().used_Sprite = get_parent().get_node("Raven_Sprite")
		get_parent().used_Sprite.set_visible(true)
		get_node("/root/PlayerStats").increment_garlics()
		
		
