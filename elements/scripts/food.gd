extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("food")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_food_body_body_entered(body: Node2D) -> void:
	print("entered: ", body.name, " groups: ", body.get_groups())
	if body.is_in_group("player"):
		PlayerVariables.eat_food()
	queue_free() # Replace with function body.
