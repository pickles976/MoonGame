class_name LandingCraft
extends Node3D

@export var is_highlightable: bool = true
@export var is_selectable: bool = true

@onready var menu : Container = %LanderMenu
@onready var mesh : MeshInstance3D = %MeshInstance3D

@onready var spawn_point: Vector3 = self.position + Vector3.RIGHT
@onready var waypoint: Vector3 = spawn_point

func _ready():
	Pathfinding.add_obstacle(self)
	
func _exit_tree():
	Pathfinding.remove_obstacle(self)
	
func on_mouse_over(pos):
	Outliner.add_outline(mesh)
	
func on_mouse_exit(pos):
	Outliner.remove_outline(mesh)
	
func on_right_click(result: Dictionary):
	waypoint = result.position

func select():
	menu.enable(self)
	
func deselect():
	menu.disable()
