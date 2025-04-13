extends Node2D

@onready var number_popup: PackedScene = preload("res://scenes/statsdisplay/numberpopup.tscn")

@onready var energy_bar: ProgressBar = $Energy/ProgressBar
@onready var morale_bar: ProgressBar = $Morale/ProgressBar
@onready var hunger_bar: ProgressBar = $Hunger/ProgressBar

@onready var energy_label: Label = $Energy/Label
@onready var morale_label: Label = $Morale/Label
@onready var hunger_label: Label = $Hunger/Label

@onready var knowledge_label: Label = $IQ
@onready var communication_label: Label = $Comm

@onready var proj_technical_score: Label = $"Project Container/ScoreTechnical"
@onready var proj_originality_score: Label = $"Project Container/ScoreOriginality"
@onready var proj_ux_score: Label = $"Project Container/ScoreUX"

@export var test_score: int = 0

var COLOR_BAD: Color = Color.DARK_RED
var COLOR_GOOD: Color = Color.SEA_GREEN
var COLOR_NORMAL: Color = Color.AZURE

var stats: Dictionary[Stats.StatType, float] = {}
@onready var labels: Dictionary[Stats.StatType, Label] = {
	Stats.StatType.HUNGER: hunger_label,
	Stats.StatType.ENERGY: energy_label,
	Stats.StatType.KNOWLEDGE: knowledge_label,
	Stats.StatType.MORALE: morale_label,
	Stats.StatType.COMMUNICATION: communication_label,
	Stats.StatType.PROJ_TECHNICAL: proj_technical_score,
	Stats.StatType.PROJ_ORIGINALITY: proj_originality_score,
	Stats.StatType.PROJ_USER_EXPERIENCE: proj_ux_score
}

func _ready() -> void:
	for k in Stats.stats:
		stats[k] = Stats.stats[k]
		
	var sb = StyleBoxFlat.new()
	sb.bg_color = Color.YELLOW
	energy_bar.add_theme_stylebox_override('fill', sb)
	
	sb = StyleBoxFlat.new()
	sb.bg_color = Color.WEB_GREEN
	morale_bar.add_theme_stylebox_override('fill', sb)
	
	sb = StyleBoxFlat.new()
	sb.bg_color = Color.DARK_RED
	hunger_bar.add_theme_stylebox_override('fill', sb)
	
	
	

func _process(delta: float):
	for stat in stats:
		if stats[stat] != Stats.stats[stat]:
			stats[stat] = lerp(stats[stat], float(Stats.stats[stat]), delta * 4)
	
	for stat in stats:

		var value: int = round(stats[stat])

		if stat == Stats.StatType.HUNGER: 
			hunger_bar.value = value
		if stat == Stats.StatType.ENERGY: 
			energy_bar.value = value
		if stat == Stats.StatType.KNOWLEDGE: 
			knowledge_label.text = 'IQ: %s' % (value + 100)
		if stat == Stats.StatType.MORALE: 
			morale_bar.value = value
		if stat == Stats.StatType.COMMUNICATION: 
			communication_label.text = 'COMM: %s' % value
		if stat == Stats.StatType.PROJ_TECHNICAL: 
			proj_technical_score.text = int_to_letter(value)
		if stat == Stats.StatType.PROJ_ORIGINALITY: 
			proj_originality_score.text = int_to_letter(value)
		if stat == Stats.StatType.PROJ_USER_EXPERIENCE: 
			proj_ux_score.text = int_to_letter(value)

		var c: Color = labels[stat].get_theme_color("font_color")
		labels[stat].set("theme_override_colors/font_color", c.lerp(COLOR_NORMAL, delta * 4))
	
	### TESTING

	if Input.is_action_just_pressed('up'):	
		var effect = Event.Effect.new({'stat': Stats.StatType.keys().pick_random(), 'value': randi_range(-10, 10), 'type': 'ADDITIVE'})
		_on_effect(effect)

func _on_effect(effect: Event.Effect):
		
	var positive = ((effect.type == Event.StatChangeType.MULTIPLICATIVE 
		and effect.value >= 1) 
		or effect.value > 0)
	
	if effect.stat == Stats.StatType.HUNGER:
		positive = !positive
	
	var color = COLOR_GOOD if positive else COLOR_BAD
	
	labels[effect.stat].set("theme_override_colors/font_color", color)
	
	var popup: NumberPopup = number_popup.instantiate()
	popup.position = labels[effect.stat].global_position
	popup.position.x = 200
	popup.position.y += 30
	popup.color = color
	
	if effect.type == Event.StatChangeType.MULTIPLICATIVE:
		popup.val = '%s' % int(round((effect.value - 1) * 10))
		if effect.value >= 1:
			popup.val = '+' + popup.val 
		
		popup.val += '%'
	else:
		popup.val = '%s' % int(round(effect.value))
		if effect.value >= 0:
			popup.val = '+' + popup.val
	
	add_child(popup)	

func int_to_letter(v: int) -> String:
	var grades = ['F-', 'F', 'F+', 'D-', 'D', 'D+', 'C-', 'C', 'C+', 'B-', 'B', 'B+', 'A-', 'A', 'A+']
	
	if v > 130:
		return 'SSS'
	if v > 120:
		return 'SS'
	if v > 100:
		return 'S'
	
	for i in range(15):
		if v < i * (100 / len(grades)):
			return grades[i]
	
	return "A+"	
