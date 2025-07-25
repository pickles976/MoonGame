extends Node3D

@export var is_highlightable: bool = true
@export var is_selectable: bool = false

func on_mouse_over(pos):
	$HighlightSquare.position = pos.snappedf(Pathfinding.grid_size)
	
func on_mouse_exit(pos):
	$HighlightSquare.position = Vector3(0,-1,0)
