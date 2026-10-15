extends CharacterBody2D
var speed = 5000.0
var friction = 0.8
var activity_time = 3

@onready var sprite = $EnemyMicrobe1
@onready var timer = $"Activity Timer"
@onready var motion_timer = $"Motion Timer"
var state = 0 # 0 = idle, 1 = fleeing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("carnivore")
	rotation = randf_range(0, 360) 
	speed = speed * randf_range(0.5, 2)
	activity_time = activity_time * randf_range(0.7, 1.3)
	scale = scale * (1 + PlayerVariables.growth_index + randf_range(-0.5, 0.2))

	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	if motion_timer.is_stopped():
		velocity = Vector2(speed * delta, 0).rotated(rotation) 
		motion_timer.start(activity_time * (1 - 0.5 * state))
	else:
		velocity = Vector2(move_toward(velocity.length(), 0, velocity.length() * friction * delta), 0).rotated(rotation)
	move_and_slide()

func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("carnivore") && body.scale >= scale:
		state = 1
		look_at(body.position)
		rotation = rotation * -1
	elif body.is_in_group("food"):
		look_at(body.position)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.scale > scale:
		PlayerVariables.eat_food(ceil(scale.length() * 5))
		queue_free()
	elif body.is_in_group("player"):
		PlayerVariables.take_damage(15)


func _on_detection_radius_area_exited(area: Area2D) -> void:
	state = 0
