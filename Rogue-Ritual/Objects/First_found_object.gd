extends Sprite

signal object_pressed

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		
		
		if is_pixel_opaque(get_local_mouse_position()):
			if event.pressed:
				emit_signal("object_pressed")
				print("Signal is sent")
