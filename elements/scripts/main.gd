extends Node2D

	
func game_over():
	$HUD/MilestoneTimerLabel/MilestoneTimer.stop()

	
	
func _on_milestone_timer_timeout():
	PlayerVariables.player_health -= int(PlayerVariables.player_health / 3)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if PlayerVariables.player_health == 0:
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	pass
