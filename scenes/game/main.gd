extends Node2D

@onready var timer = $Timer
@onready var stats = $Statsdisplay

func _ready() -> void:
	EventManager.initEvents()
	GlobalSignals.connect("event_started", _on_event_started)
	GlobalSignals.connect("event_completed", _on_event_completed)

func _on_timer_timeout() -> void:
	GameManager.timerTick()
	stats.time.text = 'TIME LEFT\n%d:%02d' % [GameManager.time / 60, GameManager.time % 60]

func _on_event_started(event) -> void:
	timer.paused = true

func _on_event_completed() -> void:
	GameManager.eventCompleted()
	timer.paused = false
