extends Node3D


func on_mouse_over(pos):
	$HighlightSquare.position = pos.snappedf(Pathfinding.grid_size)
	
func on_mouse_exit(pos):
	$HighlightSquare.position = Vector3(0,-1,0)
