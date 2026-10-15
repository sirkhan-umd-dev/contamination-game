extends CanvasLayer
@onready var health_bar = $HealthBar
@onready var stamina_label: Label = $Stamina
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVariables.health_changed.connect(_on_health_change)
	PlayerVariables.stamina_changed.connect(_on_stamina_changed)
	#Set Health Bar to max hp
	health_bar.max_value = PlayerVariables.max_health
	health_bar.value = PlayerVariables.player_health
	
	PlayerVariables.food_eaten.connect(_on_food_eaten)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar.value = PlayerVariables.player_health
	
	
func _on_health_change(current: int, maximum: int):
	health_bar.max_value = maximum
	health_bar.value = current

func _on_stamina_changed(current: int, maximum: int) -> void:
	stamina_label.text = "Stamina: %d/%d" % [current, maximum]
	var color := Color.GREEN if current > 0 else Color.GRAY
	stamina_label.add_theme_color_override("font_color", color)

func _on_food_eaten(amount: int) -> void:
	print("Food Eaten: ", amount)
	$FoodEaten.text = "Food Eaten: %d" % amount

func _on_milestone_timer_timeout() -> void:
	var damage = int(PlayerVariables.max_health / 3)
	PlayerVariables.take_damage(damage) 
