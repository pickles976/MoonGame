extends Node

var currently_selected: SelectionComponent

func set_selected(selection_component: SelectionComponent):
	
	if selection_component == currently_selected:
		return
		
	if currently_selected:
		currently_selected.deselect()
		
	selection_component.select()
	currently_selected = selection_component

func deselect():
	if currently_selected:
		currently_selected.deselect()
		currently_selected = null

func handle_right_click(result: Dictionary):
	if currently_selected:
		var node = currently_selected.get_parent()
		var movement_component = node.get("movement_component")
		
		if movement_component:
			movement_component.set_waypoint(result.position)
	
