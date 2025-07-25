extends Node3D

@onready var menu : Container = %RoverMenu
@onready var selection_component: SelectionComponent = %SelectionComponent
@onready var movement_component: MovementComponent = %MovementComponent

var waypoint: Vector3
var speed: float = 0.01

func _ready():
	selection_component.on_select_callback = func ():
			menu.visible = true
			
	selection_component.on_deselect_callback = func ():
			menu.visible = false
			
# TODO: make this into a behavior
func _process(delta: float) -> void:
	movement_component.seek_point(delta)

func move_to(pos: Vector3):
	waypoint = pos
	waypoint.y = position.y
	
