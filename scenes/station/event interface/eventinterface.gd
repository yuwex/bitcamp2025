class_name EventInterface
extends CanvasLayer

var event: Event

var buttons: Array[Button] = []
var items: Array[Label] = []

@onready var description: Label = $Description
@onready var option_template: Label = $Option
@onready var desc_anim: AnimationPlayer = $Description/AnimationPlayer


func _ready() -> void:
	
	### TESTING
	#EventManager.initEvents()
	#event = EventManager.allEvents[0]
	###
	
	assert(event, "Event must be passed")
	
	items = [description]
	var options: Array[Button] = []
	
	description.text = event.description
	
	desc_anim.play('appear')
	
	await get_tree().create_timer(1).timeout
	
	for option in event.options:
		var container: Label = option_template.duplicate()
		add_child(container)
		container.text = option.description
		
		container.visible = true
		
		var children = container.get_children()
		var button: Button = children[children.find_custom(func(child): return child is Button)]
		button.disabled = true
		var animationplayer: AnimationPlayer = children[children.find_custom(func(child): return child is AnimationPlayer)]
		animationplayer.play('appear')
		
		buttons.append(button)
		button.pressed.connect(func (): option_chosen(option))
		
		items.append(container)
		
		var timer: SceneTreeTimer = get_tree().create_timer(0.5)
		timer.connect('timeout', func(): button.disabled = false)
		
		
func _process(delta: float):
	var i = 0

	var screen_height = get_viewport().get_visible_rect().size.y
	var enabled = 0
	
	for item in items:
		if item.visible:
			enabled += 1 
	
	for item in items:
				
		var ty = (i * screen_height) / enabled + (screen_height / 2) / enabled - 50
		
		item.position = item.position.lerp(Vector2(item.position.x, ty), delta * 4)
		
		i += 1
		

func option_chosen(option: Event.Option):
	
	for button in buttons:
		button.disabled = true
	
	for item in items:
		var children = item.get_children()
		var anim: AnimationPlayer = children[children.find_custom(func(child): return child is AnimationPlayer)]
		
		if item.text != option.description:
			anim.play('disappear')
		else:
			anim.play('selected')
	
	Stats.new().apply_effects(option.effects)
	
	await get_tree().create_timer(1).timeout
	
	GlobalSignals.event_completed.emit()
