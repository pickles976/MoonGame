extends Node

var currently_selected: Node3D

func set_selected(object: Node3D):
	
	if object == currently_selected:
		return
		
	if currently_selected:
		currently_selected.deselect()
		
	object.select()
	currently_selected = object

func deselect():
	if currently_selected:
		currently_selected.deselect()
		currently_selected = null

func handle_right_click(result: Dictionary):
	if currently_selected:
		if currently_selected.has_method("on_right_click"):
			currently_selected.on_right_click(result)
