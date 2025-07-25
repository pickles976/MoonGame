extends Node3D

@export var is_highlightable: bool = true
@export var is_selectable: bool = true

@onready var menu : Container = %LanderMenu
@onready var mesh : MeshInstance3D = %MeshInstance3D

func _ready():
	Pathfinding.add_obstacle(self)
	
func _exit_tree():
	Pathfinding.remove_obstacle(self)
	
func on_mouse_over(pos):
	Outliner.add_outline(mesh)
	
func on_mouse_exit(pos):
	Outliner.remove_outline(mesh)
	
func on_right_click(result: Dictionary):
	pass

func select():
	menu.visible = true
	
func deselect():
	menu.visible = false
