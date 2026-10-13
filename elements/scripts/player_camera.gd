extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("camera ready: ", self, " enabled: ", enabled)
	PlayerVariables.player_camera = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
