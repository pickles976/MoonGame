extends Node

var INITIAL_RESOURCES_PER_GRID_SQUARE: float = 1.0

var WIDTH: int = 100

# Initialize a map with regolith
var regolith_map: Dictionary

var total_mined_regolith: float = 0.0

var power_produced: float = 0.0
var power_consumed: float = 0.0
var efficiency: float = 1.0

func _ready():
	set_process_priority(99999) 
	_init_regolith_map()
	
func _process(delta: float) -> void:
	efficiency = min(1.0, power_produced / power_consumed)
	power_produced = 0.0
	power_consumed = 0.0
	
func produce_power(value: float):
	power_produced += value
	
func consume_power(value: float):
	power_consumed += value

func _init_regolith_map():
	for i in range(-WIDTH, WIDTH):
		for j in range(-WIDTH, WIDTH):
			regolith_map[Vector3(i, 0.0, j)] = INITIAL_RESOURCES_PER_GRID_SQUARE
		
func get_regolith_at_position(position: Vector3) -> float:
	position = Pathfinding.snap(position)
	if regolith_map.has(position):
		return regolith_map[position]
	return 0.0
	
func mine_regolith(position: Vector3, rate: float) -> float:
	position = Pathfinding.snap(position)
	if not regolith_map.has(position):
		return 0.0
		
	var regolith_mined_this_tick = min(rate, regolith_map[position])
	regolith_map[position] -= regolith_mined_this_tick
	total_mined_regolith += regolith_mined_this_tick
	return regolith_mined_this_tick
	
func consume_regolith(amount: float):
	total_mined_regolith -= amount
	
