extends CharacterBody2D 

# Movement speed
@export var speed := 200

# References to AnimatedSprite2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector := Vector2.ZERO
	
	# Basic WASD / Arrow Key Movement
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Sprinting
	var sprint = Input.is_action_pressed("sprint")
	
	if sprint:
		speed = 400
	else:
		speed = 200
	
	# Normalize diagonal movement
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
		play_walk_animation(input_vector, speed)
	else:
		velocity = Vector2.ZERO
		anim_sprite.stop()
		
	move_and_slide()

func play_walk_animation(direction: Vector2, speed: int):
	# Determine direction-based animation
	if direction.x != 0:
		anim_sprite.speed_scale = speed / 200
		anim_sprite.animation = "walk_right" if direction.x > 0 else "walk_left"

	if not anim_sprite.is_playing():
		anim_sprite.play()
