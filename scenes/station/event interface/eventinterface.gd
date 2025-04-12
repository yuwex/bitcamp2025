extends CanvasLayer

var event: Event

var buttons: Array[Button] = []
var items: Array[Label] = []

@onready var description: Label = $Description
@onready var option_template: Label = $Option
@onready var desc_anim: AnimationPlayer = $Description/AnimationPlayer

func _ready() -> void:
	
	### TESTING
	EventManager.initEvents()
	event = EventManager.allEvents[0]
	###
	
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
		
		
func _process(_delta: float):
	var i = 0

	var screen_width = get_viewport().get_visible_rect().size.y

	for item in items:
		
		# add easing
		
		var y = (i * screen_width / 1.5) / len(items) + (screen_width / 1.5) / 4
		
		print(y)
		item.position.y = y
		
		i += 1
		

func option_chosen(option: Event.Option):
	for button in buttons:
		button.disabled = true
	
	# TODO: Some sort of callback with the option passed
	
	# TODO: Some sort of animation when choice is chosen
	
	
	
