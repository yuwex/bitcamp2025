extends Node2D

@export var station_type : Event.Station
@export var npc_texture : Texture

@onready var notification = $Notification
@onready var interact = $Table/Radius

@onready var table_sprite = $TableSprite
@onready var npc_sprite = $NPCSprite

func _ready():
	GlobalSignals.connect("start_events", _on_start_events)
	GlobalSignals.connect("events_ignored", _on_events_ignored)
	GlobalSignals.connect("event_started", _on_event_started)
	GlobalSignals.connect("event_completed", _on_event_completed)
	notification.visible = false
	
	table_sprite.region_enabled = true
	
	if station_type == Event.Station.WORKSHOP:
		table_sprite.region_rect = Rect2(0, 32, 32, 16)
	elif station_type == Event.Station.SPONSOR:
		table_sprite.region_rect = Rect2(0, 48, 32, 16)
		npc_sprite.texture = npc_texture
	elif station_type == Event.Station.FOOD:
		table_sprite.region_rect = Rect2(0, 64, 32, 16)
		npc_sprite.visible = false
	elif station_type == Event.Station.HARDWARE:
		table_sprite.region_rect = Rect2(32, 32, 32, 16)
		npc_sprite.texture = npc_texture
	elif station_type == Event.Station.HACKING:
		table_sprite.region_rect = Rect2(32, 48, 32, 16)
		npc_sprite.texture = npc_texture
		npc_sprite.region_rect = Rect2(32, 16, 16, 16)
		npc_sprite.position = Vector2(npc_sprite.position[0] - 5, npc_sprite.position[1] + 10)
		npc_sprite.z_index += 1

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
