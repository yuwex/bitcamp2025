extends Node

var allEvents: Array[Event]

func initEvents() -> void: 
	var file = FileAccess.open("", FileAccess.READ)
	return 
