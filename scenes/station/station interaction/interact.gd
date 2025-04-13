extends Area2D

var in_zone = false
var has_event = false
var event : Event

var interfaceScene = preload("res://scenes/station/event interface/eventinterface.tscn")
var interface

func _on_body_entered(body: Node2D) -> void:
	
	if body is CharacterBody2D:
		in_zone = true
	
func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		in_zone = false

func _process(delta: float) -> void:
	if in_zone and Input.is_action_just_pressed("interact") and has_event:
		in_zone = false
		print(event.description)
		interface = interfaceScene.instantiate()
		interface.event = event
		add_child(interface)
		GlobalSignals.event_started.emit(event)
