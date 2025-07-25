extends RayCast3D

# Raycasting vars
@export var camera: Camera3D
const RAY_LENGTH = 1000

var last_hovered: Node
var last_event: InputEvent = null

func _unhandled_input(event: InputEvent) -> void:
	last_event = event

# TODO: refactor this
func _physics_process(delta):
	
	if last_event == null:
		return
	
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	# Nothing intersected
	if result.size() == 0 or last_event == null:
		if last_hovered: last_hovered.on_mouse_exit(Vector3(0,0,0))
		last_event = null
		return
		
	# Get node
	var parent = result.collider.get_parent()
		
	if last_event.is_action("RightClick"):
		SelectionHandler.handle_right_click(result)
	elif last_event.is_action("LeftClick"):
		match parent.is_selectable:
			false: SelectionHandler.deselect()
			true: SelectionHandler.set_selected(parent)
	else:
		_handle_hover(parent, result)
	last_event = null
	
func _handle_hover(node: Node3D, result: Dictionary):
	
	if SelectionHandler.currently_selected == node:
		return
	
	if node != last_hovered: # New item hovered over
		if last_hovered:
			last_hovered.on_mouse_exit(result.position)
		last_hovered = node
	node.on_mouse_over(result.position)
	
