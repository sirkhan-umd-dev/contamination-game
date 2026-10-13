extends Node2D

@export var food_scene: PackedScene
@export var margin := 100.0
@export var dish_center := Vector2.ZERO
@export var dish_radius := Vector2(1850, 1550)  # slightly smaller than the wall

func _on_timer_timeout():
	for attempt in 20:
		var pos = _random_offscreen_position()
		if _is_inside_dish(pos):
			var food = food_scene.instantiate()
			food.global_position = pos
			add_child(food)
			return
	
func _random_offscreen_position() -> Vector2:
	var camera = get_viewport().get_camera_2d()
	var center = camera.get_screen_center_position()
	var half_size = get_viewport_rect().size / camera.zoom / 2.0
	var distance = half_size.length() + margin
	return center + Vector2.from_angle(randf() * TAU) * distance
	
func _is_inside_dish(pos: Vector2) -> bool:
	var p = (pos - dish_center) / dish_radius
	return p.length_squared() <= 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
