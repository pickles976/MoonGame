class_name Rover
extends Node3D

@export var is_highlightable: bool = true
@export var is_selectable: bool = true

@onready var menu : Container = %RoverMenu
@onready var mesh : MeshInstance3D = %MeshInstance3D

@export var speed: float = 0.01

# Behaviors
var behavior_queue: Array = []

# Mining Stuff
var regolith : float = 0.0
@export var mining_speed: float = 0.05

# power stuff
@export var power_production: float = 0.0
@export var power_consumption: float = 5.0

			
func _process(delta: float) -> void:
	Resources.produce_power(power_production)
	
	if behavior_queue.size() == 0:
		return
		
	if behavior_queue.front().is_finished:
		behavior_queue.pop_front()
	else:
		behavior_queue.front().apply(delta)
		
	

func on_mouse_over(pos):
	Outliner.add_outline(mesh)
	
func on_mouse_exit(pos):
	Outliner.remove_outline(mesh)
	
func begin_move_to(position: Vector3):
	behavior_queue.clear()
	behavior_queue.push_back(SeekBehavior.new(self, position))
	
func prioritize_behavior(behavior: Behavior):
	behavior_queue.push_front(behavior)
	
func on_right_click(result: Dictionary):
	begin_move_to(result.position)

func select():
	menu.enable(self)
	
func deselect():
	menu.disable()
