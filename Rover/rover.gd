extends Node3D

@export var is_highlightable: bool = true
@export var is_selectable: bool = true

@onready var menu : Container = %RoverMenu
@onready var mesh : MeshInstance3D = %MeshInstance3D
@onready var movement_component: MovementComponent = %MovementComponent

@export var speed: float = 0.01
var waypoint: Vector3

func _ready():
	movement_component.speed = speed
			
# TODO: make this into a behavior
func _process(delta: float) -> void:
	movement_component.seek_point(delta)

func on_mouse_over(pos):
	Outliner.add_outline(mesh)
	
func on_mouse_exit(pos):
	Outliner.remove_outline(mesh)
	
func on_right_click(result: Dictionary):
	movement_component.set_waypoint(result.position)

func select():
	menu.visible = true
	
func deselect():
	menu.visible = false
