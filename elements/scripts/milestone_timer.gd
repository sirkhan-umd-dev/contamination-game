extends RichTextLabel

@onready var milestone_timer_label: RichTextLabel = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MilestoneTimer.wait_time = 30
	$MilestoneTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_left: int = $MilestoneTimer.time_left
	milestone_timer_label.text = "%d" % [time_left]
