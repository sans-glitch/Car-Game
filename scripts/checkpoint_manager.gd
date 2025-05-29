extends Node

var next_checkpoint_num
var final_checkpoint_num
var best_times : Array
var current_times : Array
signal display_time (time_difference)
signal finished

func _ready() -> void:
	next_checkpoint_num = 0
	final_checkpoint_num = 0
	
func initalize(num):
	final_checkpoint_num = max(final_checkpoint_num, num)
	best_times.append(0)

func reset():
	next_checkpoint_num = 0
	current_times.clear()
	
func passed_through_checkpoint(checkpoint_num : int):
	print("target checkpoint:", next_checkpoint_num)
	if next_checkpoint_num == checkpoint_num:
		current_times.append(Stopwatch.time)
		var time_difference = current_times[checkpoint_num] - best_times[checkpoint_num]
		display_time.emit(time_difference)
		next_checkpoint_num += 1
		print(Stopwatch.get_time_string())
	if checkpoint_num == final_checkpoint_num:
		Stopwatch.stopped = true
		if best_times[final_checkpoint_num] == 0 or Stopwatch.time < best_times[final_checkpoint_num]:
			best_times = current_times.duplicate()
		finished.emit()
