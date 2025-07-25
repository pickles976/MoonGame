class_name SpawnerSystem
extends Node

@export var rover: PackedScene
@export var rover_menu: Container

func _spawn_scene(scene: PackedScene) -> Node3D:
	var node = scene.instantiate()
	
	var mesh: MeshInstance3D = node.get_node("MeshInstance3D")
	for i in range(mesh.get_surface_override_material_count()):
		mesh.set_surface_override_material(i, mesh.get_active_material(i).duplicate())
	
	get_parent().add_child(node)
	return node

func create_rover(lander: LandingCraft):
	var node = _spawn_scene(rover)
	node.position = lander.spawn_point
	node.menu = rover_menu
	node.begin_move_to(lander.waypoint)
	
