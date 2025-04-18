class_name GameManager

static var time : int = 36 * 60
static var events_start_cooldown : int = 5
static var events_active : bool = false
static var events_end_cooldown : int = 0
static var person_stats_timer : int = 60

static func timerTick() -> void: 
	time -= 1
	
	if time <= 0:
		GlobalSignals.time_up.emit()
		#time up
	
	if events_active:
		if events_end_cooldown > 0:
			events_end_cooldown -= 1
		if events_end_cooldown == 0:
			events_active = false
			cancelEvents()
			events_start_cooldown = 30
	else:
		if events_start_cooldown > 0:
			events_start_cooldown -= 1
		if events_start_cooldown == 0:
			events_active = true
			triggerEvents()
			events_end_cooldown = 30
	
	person_stats_timer -= 1
	if person_stats_timer <= 0:
		var human_effects : Array[Event.Effect]= [
			Event.Effect.new({"stat" : "HUNGER", "type" : "ADDITIVE", "value" : 5}),
			Event.Effect.new({"stat" : "ENERGY", "type" : "ADDITIVE", "value" : -5}),
			Event.Effect.new({"stat" : "MORALE", "type" : "ADDITIVE", "value" : -5})
		]
		Stats.new().apply_effects(human_effects)
		person_stats_timer = 60

static func eventCompleted() -> void:
	events_active = false
	events_start_cooldown = 30
	events_end_cooldown = 0
		
static func triggerEvents() -> void:
	var stations : Array[Event.Station] = [Event.Station.HACKING, Event.Station.SPONSOR, Event.Station.FOOD, Event.Station.HARDWARE, Event.Station.WORKSHOP]
	var events = chooseEvents(stations, Stats.stats, 3)
	GlobalSignals.emit_signal("start_events", events)

static func cancelEvents() -> void:
	GlobalSignals.emit_signal("events_ignored")
	
static func chooseEvents(stations: Array[Event.Station], stats: Dictionary[Stats.StatType, int], amount : int) -> Array[Event] :
	if amount > len(stations):
		var return_val : Array[Event] = []
		return return_val
		
	var res : Array[Event] = []
	for i in range(amount):
		res.append(chooseEvent(stations, stats))
		stations.erase(res[len(res) - 1].station)
	
	return res

static func chooseEvent(stations: Array[Event.Station], stats: Dictionary[Stats.StatType, int]) -> Event :
	var events = EventManager.getEvents(stations, stats)
	
	var cumulative_weight = 0
	var weights = []
	for event in events:
		weights.append(cumulative_weight)
		cumulative_weight += event.weight
	
	var target = randi_range(0, cumulative_weight - 1)
	
	if target >= weights[len(weights) - 1]:
		return events[len(weights) - 1]
		
	var l = 0
	var r = len(events) - 2
	
	while l <= r:
		var mid : int = (l + r) / 2
		if target >= weights[mid] and target < weights[mid + 1]:
			return events[mid]
		elif target >= weights[mid]:
			l = mid + 1
		else:
			r = mid - 1
	
	return events[r] #shouldn't happen
