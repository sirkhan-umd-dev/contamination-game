extends CanvasLayer
signal stat_gained(stat)

@onready var buttons: Array = [$StatOption1, $StatOption2, $StatOption3]
var current_choices: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	PlayerVariables.stat_boost.connect(_on_pick_requested)
	for i in buttons.size():
		buttons[i].pressed.connect(_on_button_pressed.bind(i))

func _on_pick_requested(choices: Array) -> void:
	current_choices = choices
	for i in buttons.size():
		buttons[i].text = str(choices[i]).capitalize()
	show()
	get_tree().paused = true

func _on_button_pressed(index: int) -> void:
	PlayerVariables.apply_stat(current_choices[index])
	hide()
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
