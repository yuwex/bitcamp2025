extends Area2D

var in_zone = false

func _on_area_entered(area: Area2D) -> void:
	in_zone = true
	
func _on_area_exited(area: Area2D) -> void:
	in_zone = false

func _process(delta: float) -> void:
	if in_zone and Input.is_action_pressed("interact"):
		print("handle signal")
