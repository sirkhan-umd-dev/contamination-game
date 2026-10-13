extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	PlayerVariables.ability_unlocked.connect(_set_notification_msg)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _set_notification_msg(ability: int) -> void:
	if ability == 0:
		$CenterContainer/Label.text = "Dash Ability Acquired"
	elif ability == 1:
		$CenterContainer/Label.text = "Shoot Ability Acquired"
	elif ability == 2:
		$CenterContainer/Label.text = "Invisibility Acquired"
	show()
	get_tree().paused = true
	

func _on_button_pressed() -> void:
	hide()
	get_tree().paused = false
