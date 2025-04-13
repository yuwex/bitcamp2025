class_name Stats

signal effect_applied(effect)

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

static var stats: Dictionary[StatType, int] = {
	StatType.HUNGER: 0,
	StatType.ENERGY: 100,
	StatType.KNOWLEDGE: 0,
	StatType.MORALE: 100,
	StatType.COMMUNICATION: 50,
	StatType.PROJ_TECHNICAL: 0,
	StatType.PROJ_ORIGINALITY: 0,
	StatType.PROJ_USER_EXPERIENCE: 0
}

func apply_effects(effects: Array[Event.Effect]):
	GlobalSignals.effects_applied.emit(effects)
	for e in effects:
		apply_effect(e)

func apply_effect(effect: Event.Effect):
	
	if effect.type == Event.StatChangeType.ADDITIVE:
		stats[effect.stat] += int(effect.value)
	elif effect.type == Event.StatChangeType.MULTIPLICATIVE:
		stats[effect.stat] = int(stats[effect.stat] * effect.value)
	
	if stats[StatType.HUNGER] >= 100:
		GameManager.time = 0
	if stats[StatType.ENERGY] <= 0:
		GameManager.time = 0
	
	effect_applied.emit(effect)

static func proj_avg() -> float:
	return (Stats.stats[StatType.PROJ_TECHNICAL] + Stats.stats[StatType.PROJ_ORIGINALITY] + Stats.stats[StatType.PROJ_USER_EXPERIENCE]) / 3
