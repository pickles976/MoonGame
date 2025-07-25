class_name MovementComponent 
extends Node

@onready var parent: Node3D = get_parent()

var path: Array[Vector3]
var speed: float = 0.01
			
func seek_point(delta: float) -> void:
	
	if path.size() == 0:
		return
	
	var waypoint = path[0];
	waypoint.y = parent.position.y
	if parent.position.distance_to(waypoint) > 0.01:
		parent.position += parent.position.direction_to(waypoint).normalized() * speed
	else:
		path.pop_front()
		
	parent.look_at(waypoint, Vector3.UP)

func set_waypoint(pos: Vector3):
	path = Pathfinding.generate_path(parent.position, pos)
