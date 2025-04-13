extends Sprite2D

@export var interface_scene : PackedScene = load("res://scenes/station/event interface/eventinterface.tscn")

func _input(event):
	if event.is_action_pressed("left-click"):
		if is_pixel_opaque(get_local_mouse_position()):
			var scene : EventInterface = interface_scene.instantiate()
			scene.event = event
