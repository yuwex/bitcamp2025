extends Node2D

@export var station_type : Event.Station

@onready var notification = $Notification
@onready var interact = $Table/Radius

func _ready():
	GlobalSignals.connect("start_events", _on_start_events)
	GlobalSignals.connect("events_ignored", _on_events_ignored)
	GlobalSignals.connect("event_started", _on_event_started)
	GlobalSignals.connect("event_completed", _on_event_completed)
	notification.visible = false
	
func _on_start_events(events: Array[Event]):
	for event in events:
		if event.station == station_type:
			notification.visible = true
			interact.has_event = true
			interact.event = event

func _on_events_ignored():
	notification.visible = false
	interact.has_event = false

func _on_event_started(event : Event) -> void:
	if event.station != station_type:
		notification.visible = false
		interact.has_event = false

func _on_event_completed() -> void:
	notification.visible = false
	interact.has_event = false
