class_name Stats

enum StatType {
	HUNGER,
	ENERGY,
	KNOWLEDGE,
	MORALE,
	COMMUNICATION,
	PROJ_TECHNICAL,
	PROJ_ORIGINALITY,
	PROJ_USER_EXPERIENCE
}

var stats: Dictionary[StatType, int]

func _init():
	stats = {
		StatType.HUNGER: 0,
		StatType.ENERGY: 100,
		StatType.KNOWLEDGE: 0,
		StatType.MORALE: 100,
		StatType.COMMUNICATION: 50,
		StatType.PROJ_TECHNICAL: 0,
		StatType.PROJ_ORIGINALITY: 0,
		StatType.PROJ_USER_EXPERIENCE: 0
	}
