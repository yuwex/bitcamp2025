extends Node2D

@onready var timer = $Timer
@onready var stats = $Statsdisplay

func _ready() -> void:
	EventManager.initEvents()
	GlobalSignals.connect("event_started", _on_event_started)
	GlobalSignals.connect("event_completed", _on_event_completed)
	GlobalSignals.connect("time_up", _on_time_up)
	GlobalSignals.connect("game_start", _on_start)

func _on_timer_timeout() -> void:
	GameManager.timerTick()
	stats.time.text = 'TIME LEFT\n%d:%02d' % [GameManager.time / 60, GameManager.time % 60]

func _on_event_started(event) -> void:
	timer.paused = true

func _on_event_completed() -> void:
	GameManager.eventCompleted()
	timer.paused = false

func _process(bru) -> void:
	if Input.is_action_just_pressed("skip-time"):
		if GameManager.time > 120:
			GameManager.time -= 120
		else:
			GameManager.time = 10
		stats.time.text = 'TIME LEFT\n%d:%02d' % [GameManager.time / 60, GameManager.time % 60]

func _on_time_up() -> void:
	$Gameover.all()
	$Gameover.visible = true

func _on_start() -> void:
	timer.start()
