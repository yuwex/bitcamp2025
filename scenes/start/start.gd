extends Node2D

func _on_button_pressed() -> void:
	GlobalSignals.game_start.emit()
	queue_free()
