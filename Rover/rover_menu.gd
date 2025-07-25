extends MarginContainer

var active_rover: Rover

@onready var spawner_system: SpawnerSystem = %SpawnerSystem
@onready var mine_button: Button = %MineButton

func _ready() -> void:
	mine_button.pressed.connect(
		func (): 
			if active_rover: 
				active_rover.behavior_queue = [AutoMineBehavior.new(active_rover)])
				
func enable(object: Rover):
	active_rover = object
	visible = true
	
func disable():
	active_rover = null
	visible = false
