extends Node3D

@onready var menu : Container = %LanderMenu
@onready var selection_component: SelectionComponent = %SelectionComponent

func _ready():
	selection_component.on_select_callback = func ():
			menu.visible = true
			
	selection_component.on_deselect_callback = func ():
			menu.visible = false

	Pathfinding.add_obstacle(self)
	
func _exit_tree():
	Pathfinding.remove_obstacle(self)
