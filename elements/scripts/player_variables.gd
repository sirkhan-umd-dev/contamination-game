extends Node
signal food_eaten(new_amount)
signal ability_unlocked(ability) # 0 = dash, 1 = slime toss, 2 = invis
signal stat_gained(stat)

@onready var milestone_timer = $HUD/MilestoneTimerLabel/MilestoneTimer
@onready var player = $Player

var food_amount := 0
var player_health := 50
var stat_pool = ["Speed", "Size", "Evasion", "Senses", "Stamina"]

func eat_food(amount := 1):
	food_amount += amount
	food_eaten.emit(food_amount)
	if(food_amount == 10): #ability gain
		handle_growth(true)
		food_amount = 0
		milestone_timer.wait_time = 20 
	elif (food_amount == 25): #ability gain
		food_amount = 0
		handle_growth(true)
		milestone_timer.wait_time = 20 
	elif (food_amount % 50 == 0): #stat boost
		handle_growth(false)
		food_amount = 0
		milestone_timer.wait_time = 20 
		
# handle the bonuses at each growth stage
func handle_growth(ability_gained: bool):
	player.scale += 10
	if ability_gained:
		ability_unlocked.emit(0)
	else:
		var stat = randi() % 5
		stat_gained.emit(stat)
		print(stat + " gained!")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
