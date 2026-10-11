extends Node
signal food_eaten(new_amount)

var food_amount := 0

func eat_food(amount := 1):
	food_amount += amount
	food_eaten.emit(food_amount)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
