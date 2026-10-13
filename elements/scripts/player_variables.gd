extends Node
signal food_eaten(new_amount)
signal ability_unlocked(ability) # 0 = dash, 1 = slime toss, 2 = invis
signal stat_gained(stat)

@onready var milestone_timer = $HUD/MilestoneTimerLabel/MilestoneTimer
@onready var player:CharacterBody2D = $Player

var food_amount := 0
var player_health := 50
var stat_pool = ["Speed", "Size", "Evasion", "Senses", "Stamina"]
var growth_index = 0
var growth_checks = [10, 25, 5]

func eat_food(amount := 1):
	food_amount += amount
	food_eaten.emit(food_amount)
	if(food_amount >= growth_checks[growth_index]): #ability gain
		handle_growth(growth_index < 2)
		food_amount = food_amount - growth_checks[growth_index]
		milestone_timer.wait_time = 20 
		growth_index = min(growth_index + 1, 2) 
		
# handle the bonuses at each growth stage
func handle_growth(ability_gained: bool):
	#player.scale = Vector2(player.scale.x + 1, player.scale.y + 1)
	if ability_gained:
		ability_unlocked.emit(0)
	else:
		var stat = randi() % 5
		stat_gained.emit(stat)
		print(stat_pool[stat] + " gained!")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
