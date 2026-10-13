extends Node
signal food_eaten(new_amount)
signal ability_unlocked(ability) # 0 = dash, 1 = slime toss, 2 = invisibility
signal stat_boost(stat_choices)
signal health_changed(current: int, maximum: int)
signal player_died

var milestone_timer: Timer = null
var player: CharacterBody2D = null
var player_camera: Camera2D = null

var food_amount := 0
var max_health := 50
var player_health := 50
var stat_pool = ["Speed", "Size", "Evasion", "Senses", "Stamina"]
var growth_index = 0
var growth_checks = [10, 25, 50]

func take_damage(amount: int) -> void:
	set_health(player_health - amount)

func set_max_health(new_max: int) -> void:
	max_health = new_max
	set_health(player_health)  # re-clamp and re-emit

func set_health(value: int) -> void:
	player_health = clampi(value, 0, max_health)
	health_changed.emit(player_health, max_health)
	if player_health == 0:
		player_died.emit()

func get_stat_choices(count: int = 3) -> Array:
	var pool := stat_pool.duplicate()
	pool.shuffle()
	return pool.slice(0, count)
	
func eat_food(amount := 1):
	food_amount += amount
	if(food_amount >= growth_checks[growth_index]): #ability gain
		handle_growth(growth_index < 2)
		food_amount = food_amount - growth_checks[growth_index]
		milestone_timer.wait_time = 20 
		growth_index = min(growth_index + 1, 2) 
	food_eaten.emit(food_amount)
	print("Food Eaten: ", amount)
	
		
# handle the bonuses at each growth stage
func handle_growth(ability_gained: bool):
	#player.scale = Vector2(player.scale.x + 1, player.scale.y + 1)
	if ability_gained:
		ability_unlocked.emit(min(growth_index, 1))
	else:
		stat_boost.emit(get_stat_choices())
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_health == 0:
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	pass
