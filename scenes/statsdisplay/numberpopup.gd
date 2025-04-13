class_name NumberPopup
extends Node2D

@onready var label: Label = $Label

# Callee-set
var color: Color
var val: String

# Internal
var vx: float
var vy: float
var target_color: Color
var end_color: Color

func _ready() -> void:

	# TESTING
	#pos = Vector2(100, 100)
	#color = Color.BLUE
	
	vx = randf_range(-5, 5) * 5
	vy = randf_range(-3, -5) * 30
	
	label.text = val
	
	target_color = color
	end_color = Color(target_color.r, target_color.g, target_color.b, 1.0)
	
func _process(delta: float) -> void:
	position += Vector2(vx, vy) * delta
	vy += 9.8 * 50 * delta
	
	if vy > 0:
		scale = scale.lerp(Vector2(0, 0), delta)
		get_tree().create_timer(0.25).timeout.connect(func(): queue_free())
	
	var c: Color = label.get_theme_color("font_color")
	label.set("theme_override_colors/font_color", c.lerp(target_color, delta * 4))
	
	
