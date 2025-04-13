extends Node

signal start_events(events : Array[Event])
signal events_ignored()
signal event_started()
signal event_completed()

signal effects_applied(effect: Array[Event.Effect])
