extends CanvasLayer
@onready var health_bar = $HealthBar
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVariables.health_changed.connect(_on_health_change)
	#Set Health Bar to max hp
	health_bar.max_value = PlayerVariables.max_health
	health_bar.value = PlayerVariables.player_health
	
	PlayerVariables.food_eaten.connect(_on_food_eaten)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar.value = PlayerVariables.player_health
	pass
	
func _on_health_change(current: int, maximum: int):
	health_bar.max_value = maximum
	health_bar.value = current

func _on_food_eaten(amount: int) -> void:
	print("Food Eaten: ", amount)
	$FoodEaten.text = "Food Eaten: %d" % amount

func _on_milestone_timer_timeout() -> void:
	var damage = int(PlayerVariables.max_health / 3)
	PlayerVariables.take_damage(damage) 
