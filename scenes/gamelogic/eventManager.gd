class_name EventManager

static var allEvents: Array[Event] = []

static func initEvents() -> void: 
	var file = FileAccess.open("res://data/events.json", FileAccess.READ)
	if file: 
		var json_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK: 
			var data = json.data
			for eventData in data["events"]:
				allEvents.append(Event.new(eventData))
				return
		else:
			push_error(json.get_error_message())
			return
	else:
		push_error(FileAccess.get_open_error())
		return

static func getEvents(stats: Dictionary[Stats.StatType, int]) -> Array[Event]:
	var res = []
	for event in allEvents:
		if event.accept(stats):
			res.append(event)
	return res
