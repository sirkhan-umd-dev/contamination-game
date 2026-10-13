extends StaticBody2D
@export var radius := Vector2(4000, 3450)  # half-width, half-height of the dish
@export var segments := 64

func _ready():
	var points := PackedVector2Array()
	for i in segments:
		var angle = TAU * i / segments
		points.append(Vector2(cos(angle), sin(angle)) * radius)

	var outline = CollisionPolygon2D.new()
	outline.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
	outline.polygon = points
	add_child(outline)
