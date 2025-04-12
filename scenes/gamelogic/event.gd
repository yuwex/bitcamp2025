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
	
	func accept(stats: Stats) -> bool:
		#if stats.stats[stat] ...
		return false

class Effect:
	var stat: Stats.StatType
	var type: StatChangeType
	var value: float
	
	func apply(stats: Stats) -> void:
		return

class Option:
	var description: String
	var trigger: int
	var effect: Array[Effect]

var id: String
var condition: Array[Condition]
var weight: int
var station: Event.Station
var description: String
var options: Array[Option]

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
