class_name SelectionComponent 
extends Node

var on_select_callback: Callable
var on_deselect_callback: Callable

var mesh: MeshInstance3D
var is_selected: bool = false

func _ready():
	mesh = %MeshInstance3D

func on_mouse_over(pos):
	if is_selected: return
	Outliner.add_outline(mesh)
	
func on_mouse_exit(pos):
	if is_selected: return
	Outliner.remove_outline(mesh)
	
func select():
	if on_select_callback: on_select_callback.call()
	is_selected = true
	Outliner.remove_outline(mesh)
	
func deselect():
	if on_deselect_callback: on_deselect_callback.call()
	is_selected = false
	
