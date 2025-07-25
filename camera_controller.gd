extends Node3D

@export var camera_speed: float = 5.0;
@export var camera: Camera3D

func _process(delta: float) -> void:
	if Input.is_action_pressed("MoveForward"):
		self.position -= self.basis.z * camera_speed * delta
		
	if Input.is_action_pressed("MoveBackward"):
		self.position += self.basis.z * camera_speed * delta
		
	if Input.is_action_pressed("MoveRight"):
		self.position += self.basis.x * camera_speed * delta
		
	if Input.is_action_pressed("MoveLeft"):
		self.position -= self.basis.x * camera_speed * delta
		
	if Input.is_action_just_released("ZoomIn"):
		camera.size -= 1
		
	if Input.is_action_just_released("ZoomOut"):
		camera.size += 1
