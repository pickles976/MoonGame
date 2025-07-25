class_name SeekBehavior
extends Behavior

var path: Array[Vector3]
var position: Vector3

func _init(agent: Node3D, position: Vector3) -> void:
	self.agent = agent
	self.position = position
	self.path = Pathfinding.generate_path(agent.position, position)
			
func apply(delta: float) -> void:
	
	if path.size() == 0:
		self.is_finished = true
		return
	
	var waypoint = path[0];
	waypoint.y = agent.position.y
	if agent.position.distance_to(waypoint) > 0.01:
		agent.position += agent.position.direction_to(waypoint).normalized() * agent.speed
	else:
		path.pop_front()
		
	agent.look_at(waypoint, Vector3.UP)
