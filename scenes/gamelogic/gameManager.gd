class_name GameManager

static var time : int = 0;
static var event_cooldown : int = 45;

static func timerTick() -> void: 
	time += 1
	event_cooldown -= 1
	
	if event_cooldown == 0:
		triggerEvents()
		
static func triggerEvents() -> void:
	var stations : Array[Event.Station] = [Event.Station.HACKING, Event.Station.SPONSOR, Event.Station.FOOD, Event.Station.HARDWARE, Event.Station.WORKSHOP, Event.Station.EXIT, Event.Station.PRESENTATION]
	var events = chooseEvents(stations, Stats.stats, 3)
	# PASS EVENTS TO STATIONS HERE
	
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
