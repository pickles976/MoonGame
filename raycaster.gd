extends RayCast3D

# Raycasting vars
@export var camera: Camera3D
const RAY_LENGTH = 1000

var last_hovered: Node

# TODO: refactor this
func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	# Nothing intersected
	if result.size() == 0:
		if last_hovered: last_hovered.on_mouse_exit(Vector3(0,0,0))
		return
		
	# Check for component
	var parent = result.collider.get_parent()
	var selection_component = parent.get("selection_component")
		
	if Input.is_action_just_pressed("RightClick"):
		SelectionHandler.handle_right_click(result)
	elif Input.is_action_just_pressed("LeftClick"):
		match selection_component:
			null: SelectionHandler.deselect()
			_: SelectionHandler.set_selected(selection_component)
	else:
		print(result.collider.get_parent())
		match selection_component:
			null: _handle_hover_unselectable(result)
			_: _handle_hover_selectable(selection_component, result)
	
func _handle_hover_selectable(selection_component: SelectionComponent, result: Dictionary):
	
	if selection_component != last_hovered: # New item hovered over
		if last_hovered:
			last_hovered.on_mouse_exit(result.position)
		last_hovered = selection_component
	selection_component.on_mouse_over(result.position)
	
func _handle_hover_unselectable(result: Dictionary):
	
	var parent = result.collider.get_parent()

	if not (parent.has_method("on_mouse_over") and parent.has_method("on_mouse_exit")):
		return
	
	if parent != last_hovered: # New item hovered over
		if last_hovered:
			last_hovered.on_mouse_exit(result.position)
		last_hovered = parent
	parent.on_mouse_over(result.position)
		
