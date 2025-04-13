extends Area2D

var in_zone = false
var has_event = false
var event : Event

var interfaceScene = preload("res://scenes/station/event interface/eventinterface.tscn")
var interface

func _on_area_entered(area: Area2D) -> void:
	in_zone = true
	print(in_zone)
	
func _on_area_exited(area: Area2D) -> void:
	in_zone = false
	print(in_zone)

func _process(delta: float) -> void:
	if in_zone and Input.is_action_just_pressed("interact") and has_event:
		in_zone = false
		print(event.description)
		interface = interfaceScene.instantiate()
		interface.event = event
		add_child(interface)
		GlobalSignals.event_started.emit(event)
