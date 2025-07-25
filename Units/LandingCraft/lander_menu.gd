extends MarginContainer

var active_lander: LandingCraft

@onready var spawner_system: SpawnerSystem = %SpawnerSystem
@onready var create_rover_button: Button = %CreateRoverButton

func _ready() -> void:
	create_rover_button.pressed.connect(
		func (): 
			if active_lander: spawner_system.create_rover(active_lander))

func enable(object: LandingCraft):
	active_lander = object
	visible = true
	
func disable():
	active_lander = null
	visible = false
