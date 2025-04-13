extends Node2D

func _ready() -> void:
	EventManager.initEvents()
	GameManager.triggerEvents()

func _on_timer_timeout() -> void:
	pass
	# GameManager.timerTick()
