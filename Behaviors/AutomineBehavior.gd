class_name AutoMineBehavior
extends Behavior

var RANDOM_WALK_STEP : float = 5.0
var rng = RandomNumberGenerator.new()

func _init(agent: Node3D) -> void:
	self.agent = agent
			
func apply(delta: float) -> void:
	
	if agent.regolith > agent.max_regolith_capacity:
		# Go to first RegolithProcessor we find to drop off resources
		# TODO: pick the closest one
		for key in Pathfinding.obstacle_dict:
			var object = Pathfinding.obstacle_dict[key]
			if object is RegolithProcessor:
				agent.prioritize_behavior(SeekBehavior.new(agent, object.position + Vector3.RIGHT))
	elif Resources.get_regolith_at_position(agent.position) > 0.0:
		Resources.consume_power(agent.power_consumption)
		agent.regolith += Resources.mine_regolith(agent.position, agent.mining_speed * Resources.efficiency * delta)
	else:
		# TODO: complicated resource search behavior
		
		# Random Walk
		var random_direction = Vector3(
			rng.randf_range(-RANDOM_WALK_STEP, RANDOM_WALK_STEP), 
			0.0, 
			rng.randf_range(-RANDOM_WALK_STEP, RANDOM_WALK_STEP))
		var new_pos = (agent.position + random_direction).snappedf(Pathfinding.grid_size)
		agent.prioritize_behavior(SeekBehavior.new(agent, new_pos))
			
