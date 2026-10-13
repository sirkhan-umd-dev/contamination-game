extends CharacterBody2D
var speed = 4000.0
var friction = 0.8
var activity_time = 3
var target_direction

@onready var sprite = $EnemyMicrobe2
@onready var timer = $"Activity Timer"
@onready var detection = $"Detection Radius"
var state = 0 # 0 = idle, 1 = fleeing, 2 = chasing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randf_range(0, 360) 
	speed = speed * randf_range(0.5, 2)
	activity_time = activity_time * randf_range(0.7, 1.3)
	scale = scale * (1 + PlayerVariables.growth_index + randf_range(-0.2, 0.5))
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var overlapping_bodies: Array[Node2D] = detection.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.scale < scale:
			look_at(body.position)
			pass
			
	velocity = Vector2(speed * delta, 0).rotated(rotation)
	move_and_slide()

func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("carnivore") && body.scale > scale:
		state = 1
		look_at(body.position)
		rotation = rotation * -1
	elif body.is_in_group("food") || body.scale < scale:
		look_at(body.position)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("carnivore") && body.scale > scale:
		if body.is_in_group("player"):
			PlayerVariables.eat_food(ceil(scale.length() * 5))
		
		queue_free()

func _on_detection_radius_area_exited(area: Area2D) -> void:
	state = 0
