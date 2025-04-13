extends Node2D

func _ready() -> void:
	EventManager.initEvents()

func _on_timer_timeout() -> void:
	GameManager.timerTick()
