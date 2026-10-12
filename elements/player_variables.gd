extends Node
signal food_eaten(new_amount)
signal ability_unlocked(ability) # 0 = dash, 1 = slime toss, 2 = slime trail

var food_amount := 0
var player_health := 50
var stat_pool = ["Speed", "Size", "Evasion", "Senses", "Stamina"]
func eat_food(amount := 1):
	food_amount += amount
	food_eaten.emit(food_amount)
	if(food_amount == 10): #ability gain
		handle_growth(true)
	elif (food_amount == 25): #ability gain
		handle_growth(true)
	elif (food_amount % 50 == 0): #stat boost
		handle_growth(false)
		
# handle the bonuses at each growth stage
func handle_growth(ability_gained: bool):
	if ability_gained:
		ability_unlocked.emit(0)
	else:
		pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
