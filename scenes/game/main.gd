extends Node2D

func _ready() -> void:
	EventManager.initEvents()
	print(EventManager.getEvents([Event.Station.HACKING], Stats.stats))
