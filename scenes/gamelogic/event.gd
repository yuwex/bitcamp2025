class_name Event

enum Station {
	HACKING,
	SPONSOR,
	FOOD,
	HARDWARE,
	WORKSHOP,
	EXIT,
	PRESENTATION
}

enum StatChangeType {
	ADDITIVE,
	MULTIPLICATIVE
}

class Condition:
	var stat: Stats.StatType
	var min: float
	var max: float
	
	func _init(data: Dictionary) -> void:
		stat = Stats.StatType[data["stat"]]
		min = data["min"]
		max = data["max"]
	
	func accept(stats: Dictionary[Stats.StatType, int]) -> bool:
		return stats[stat] >= min and stats[stat] <= max

class Effect:
	var stat: Stats.StatType
	var type: StatChangeType
	var value: float
	
	func _init(data: Dictionary) -> void:
		stat = Stats.StatType[data["stat"]]
		type = StatChangeType[data["type"]]
		value = float(data["value"])
	
	func apply(stats: Stats) -> void:
		return

class Option:
	var description: String
	var trigger: int
	var effects: Array[Effect]
	
	func _init(data: Dictionary) -> void:
		description = data["description"]
		trigger = data["trigger"]
		effects = []
		for effectData in data["effects"]:
			effects.append(Effect.new(effectData))

var id: int
var conditions: Array[Condition]
var weight: int
var station: Event.Station
var description: String
var options: Array[Option]

func _init(data: Dictionary) -> void:
	id = int(data["id"])
	conditions = []
	for conditionData in data["conditions"]:
		conditions.append(Condition.new(conditionData))
	weight = int(data["weight"])
	station = Event.Station[data["station"]]
	description = data["description"]
	options = []

func accept(station: Event.Station, stats: Dictionary[Stats.StatType, int]) -> bool:
	if self.station != station:
		return false
	for condition in conditions:
		if not condition.accept(stats):
			return false
	return true

# id: str
# condition: list[condition]
# # stat
# # min
# # max
# weight: int
# station: enum
# description: str
# options: list[option]
# # description: str
# # trigger: null, ID
# # effects: list[effect]
# # # stat: Stat
# # # change_type: enum
# # # change_value: float
