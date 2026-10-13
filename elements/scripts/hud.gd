extends CanvasLayer
@onready var health_bar = $HealthBar
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Set Health Bar to max hp
	health_bar.max_value = PlayerVariables.player_health
	
	PlayerVariables.food_eaten.connect(_on_food_eaten)
	_on_food_eaten(PlayerVariables.food_amount)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar.value = PlayerVariables.player_health
	pass
	
func _on_food_eaten(amount: int) -> void:
	$FoodEaten.text = "Food Eaten: %d" % amount
