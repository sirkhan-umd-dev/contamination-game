extends CharacterBody2D

@export var speed = 10000.0
@export var stamina = 3
@export var max_stamina = 3
@export var friction = 0.95
var dash_unlocked = false
var shoot_unlocked = false
var trail_unlocked = false

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _dash_duration = $DashDuration
@onready var _stamina_cooldown = $StaminaCooldown

func _ready() -> void:
	PlayerVariables.ability_unlocked.connect(_on_ability_gained)
	
func _process(_delta):
	
	_animated_sprite.play("default")
	
	if stamina < max_stamina && _stamina_cooldown.is_stopped():
		_stamina_cooldown.start()

func _physics_process(delta: float) -> void:
	
	if _dash_duration.is_stopped():
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var xDirection := Input.get_axis("left", "right")
		if xDirection:
			velocity.x = xDirection * speed * delta
		else:
			velocity.x = move_toward(velocity.x, 0, speed * delta)
		
		var yDirection := Input.get_axis("up", "down")
		if yDirection:
			velocity.y = yDirection * speed * delta
		else:
			velocity.y = move_toward(velocity.y, 0, speed * delta)
		
		if dash_unlocked && Input.is_action_just_pressed("dash") && stamina > 0:
			stamina -= 1
			print(stamina)
			velocity = Vector2(xDirection * speed * delta * 3, yDirection * speed * delta * 3)
			_dash_duration.start()
	else:
		velocity *= friction
	move_and_slide()

func _on_stamina_cooldown_timeout() -> void:
	stamina += 1
	print("Stamina restored")
	
func _on_ability_gained(ability: int) -> void:
	
	if ability == 0:
		dash_unlocked = true
