extends CanvasLayer


func _on_begin_pressed() -> void:
	print(InputMap.action_get_events("invis"))
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.
