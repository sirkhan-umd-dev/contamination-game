extends Node2D

@onready var milestone_timer = $HUD/MilestoneTimerLabel/MilestoneTimer

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	milestone_timer.wait_time = 20
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	if PlayerVariables.player_health == 0:
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	pass
