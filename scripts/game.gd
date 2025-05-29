extends Node3D

@export var course_num = 0
var city_grid : Array
var started : bool = false
signal start

func _ready() -> void:
	Stopwatch.stopped = true
	place_car()
	#generate_maze(10, 10)
	CheckpointManager.reset()
	start.connect(_on_race_start)
	CheckpointManager.finished.connect(finished)

func _input(event: InputEvent) -> void:
	if event.is_action("restart"):
		get_tree().reload_current_scene()

func _on_race_start():
	started = true
	Stopwatch.reset_and_start()

func generate_maze(width: int, height: int) -> void:
	# Generates empty grid
	for r in height:
		city_grid.append([])
		for c in width:
			var new_tile = Intersection.new_tile(Vector2i(c, r))
			add_child(new_tile)
			city_grid[r].append(new_tile)
	
	city_grid[randi_range(0, height-1)][randi_range(0, width-1)].gen_tile(city_grid)
			
	for r in height:
		var hori_string = ""
		var vert_string = " "
		for c in width:
			hori_string += city_grid[r][c].side_connections_to_string()
			vert_string += city_grid[r][c].vertical_connections_to_string()
		print(hori_string)
		print(vert_string)
		print("")
			
func finished():
	$Overhead.current = true
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()

func place_car():
	if course_num == 0:
		$Car.position = Vector3(0, 3, 28.556)
		$Car.rotation = Vector3(0, -PI/2, 0)
	else:
		$Car.position = Vector3(-379, 2, -210)
		$Car.rotation = Vector3(0, -PI/2, 0)
