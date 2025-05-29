extends Control

@onready var bar: Control = $Bar

signal display

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CheckpointManager.display_time.connect(display_time)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Timer.text = Stopwatch.get_time_string()

func display_time(time_difference):
	var current_time = Stopwatch.get_time_string()
	var string = current_time + "\n" + Stopwatch.time_to_string(time_difference)
	$Bar/Label.text = string
	bar.show()
	await get_tree().create_timer(1).timeout
	bar.hide()
