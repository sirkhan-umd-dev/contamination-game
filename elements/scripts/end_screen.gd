extends CanvasLayer

@onready var ending_title = $CenterContainer2/EndGameTitle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVariables.player_died.connect(_handle_death)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _handle_death():
		ending_title.text = "Game Over"

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
