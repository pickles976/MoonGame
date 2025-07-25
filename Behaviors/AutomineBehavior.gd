class_name AutoMineBehavior
extends Behavior

var RANDOM_WALK_STEP : float = 5.0
var rng = RandomNumberGenerator.new()

func _init(agent: Node3D) -> void:
	self.agent = agent
			
func apply(delta: float) -> void:
	
	if Resources.get_regolith_at_position(agent.position) > 0.0:
		agent.regolith += Resources.mine(agent.position, agent.mining_speed * delta)
		print(agent.regolith)
	else:
		# TODO: complicated resource search behavior
		
		# Random Walk
		var random_direction = Vector3(
			rng.randf_range(-RANDOM_WALK_STEP, RANDOM_WALK_STEP), 
			0.0, 
			rng.randf_range(-RANDOM_WALK_STEP, RANDOM_WALK_STEP))
		var new_pos = (agent.position + random_direction).snappedf(Pathfinding.grid_size)
		agent.prioritize_behavior(SeekBehavior.new(agent, new_pos))
			
