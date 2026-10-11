extends CharacterBody2D
const SPEED = 10000.0

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	_animated_sprite.play("default")
	
func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xDirection := Input.get_axis("left", "right")
	if xDirection:
		velocity.x = xDirection * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	
	var yDirection := Input.get_axis("up", "down")
	if yDirection:
		velocity.y = yDirection * SPEED * delta
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED * delta)
	
	
	move_and_slide()

	
