# Draw the outline around a mesh

extends Node3D

var shader: Shader = load("res://highlight_outline.gdshader")
var color: Color = Color(0,1,0)
var size: float = 2.0
var outline_mat: ShaderMaterial = ShaderMaterial.new()

func _ready():
	outline_mat.shader = shader
	outline_mat.set_shader_parameter("color", color)
	outline_mat.set_shader_parameter("size", size)

func add_outline(object: MeshInstance3D):
	for i in range(object.get_surface_override_material_count()):
		object.get_active_material(i).next_pass = outline_mat
	
func remove_outline(object: MeshInstance3D):
	for i in range(object.get_surface_override_material_count()):
		object.get_active_material(i).next_pass = null
