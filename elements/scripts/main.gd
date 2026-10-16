extends Node2D

@onready var milestone_timer = $HUD/MilestoneTimerLabel/MilestoneTimer

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVariables.player_died.connect(_show_end_screen)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _show_end_screen():
	pass
	#get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
