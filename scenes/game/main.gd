extends Node2D

@onready var timer = $Timer

func _ready() -> void:
	EventManager.initEvents()
	GlobalSignals.connect("event_started", _on_event_started)
	GlobalSignals.connect("event_completed", _on_event_completed)

func _on_timer_timeout() -> void:
	GameManager.timerTick()

func _on_event_started(event) -> void:
	timer.paused = true

func _on_event_completed() -> void:
	timer.paused = false
