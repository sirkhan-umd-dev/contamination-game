extends CharacterBody2D

@export var speed = 10000.0
@export var stamina = 3
@export var max_stamina = 3
@export var stamina_cd = 3
@export var friction = 0.95
var dash_unlocked = false
var shoot_unlocked = false
var invis_unlocked = false

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _dash_duration = $DashDuration
@onready var _stamina_cooldown = $StaminaCooldown
@onready var _collision = $CollisionShape2D
@onready var _camera = $Camera2D

func _ready() -> void:
	PlayerVariables.ability_unlocked.connect(_on_ability_gained)
	PlayerVariables.stat_gained.connect(_on_stat_gained)
	
func _process(_delta):
	
	_animated_sprite.play("default")
	
	if stamina < max_stamina && _stamina_cooldown.is_stopped():
		_stamina_cooldown.start(stamina_cd)

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

func _on_stat_gained(stat: int) -> void:
	scale = Vector2(scale.x + 0.5, scale.y + 0.5)
	if stat == 0:
		speed += 1000.0
	elif stat == 1:
		scale = Vector2(scale.x + 0.2, scale.y + 0.2)
	elif stat == 2:
		_collision.scale = Vector2(_collision.scale.x - 0.2, _collision.scale.y - 0.2)
	elif stat == 3:
		_camera.zoom = Vector2(_camera.zoom.x - 0.1, _camera.zoom.y - 0.1)
	elif stat == 4:
		stamina_cd = max(0, stamina.cd - 0.5)
