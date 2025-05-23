extends Node3D

@export var checkpoint_number : int

func _ready() -> void:
	CheckpointManager.initalize(checkpoint_number)

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("woosh")
	if body.is_in_group("Car"):
		CheckpointManager.passed_through_checkpoint(checkpoint_number)
