extends CanvasLayer

@onready var ending_title = $CenterContainer2/EndGameTitle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerVariables.player_health == 0:
		ending_title.text = "Game Over"
	else:
		ending_title.text = "The World is Yours"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
