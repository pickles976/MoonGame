class_name RegolithProcessor
extends Node3D

@export var is_highlightable: bool = true
@export var is_selectable: bool = true

@onready var mesh : MeshInstance3D = %MeshInstance3D

@export var power_production: float = 0.0
@export var power_consumption: float = 10.0

var regolith : float = 0.0
var refining_rate: float = 0.01

var customers : Array[Rover] = []

func _ready():
	Pathfinding.add_obstacle(self)
	
func _process(delta: float) -> void:
	
	for customer in customers:
		regolith += customer.regolith
		customer.regolith = 0.0
	
	if regolith > 0.0:
		var regolith_processed_this_tick = min(refining_rate * delta * Resources.efficiency, regolith)
		regolith -= regolith_processed_this_tick
		
		Resources.consume_power(power_consumption)
		
func _exit_tree():
	Pathfinding.remove_obstacle(self)
	
func on_mouse_over(pos):
	Outliner.add_outline(mesh)
	
func on_mouse_exit(pos):
	Outliner.remove_outline(mesh)
	
func on_right_click(result: Dictionary):
	pass

func select():
	pass
	#menu.enable(self)
	
func deselect():
	pass
	#menu.disable()

func _on_drop_off_area_area_entered(area: Area3D) -> void:
	var object = area.get_parent()
	if object is Rover:
		customers.append(object)

func _on_drop_off_area_area_exited(area: Area3D) -> void:
	var object = area.get_parent()
	if object is Rover:
		customers.erase(object)
