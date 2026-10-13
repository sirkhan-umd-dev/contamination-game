extends Timer

@onready var milestone_timer_label: RichTextLabel = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVariables.milestone_timer = self
	start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	milestone_timer_label.text = "%d" % [wait_time]
