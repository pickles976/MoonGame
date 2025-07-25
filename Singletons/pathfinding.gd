extends Node

const MAX_DEPTH: int = 100;
var grid_size: float = 1.0

var obstacle_dict: Dictionary = {}
var open_list: Array[SearchNode]
var closed_list: Dictionary

# TODO: do grid-related things on a Vector2
func snap(position: Vector3) -> Vector3:
	position = position.snappedf(grid_size)
	position.y = 0.0
	return position

func add_obstacle(object):
	var key = snap(object.position)
	obstacle_dict[key] = object
	
func remove_obstacle(object):
	var key = snap(object.position)
	obstacle_dict.erase(key)
	
func is_position_blocked(pos: Vector3):
	var key = snap(pos)
	return obstacle_dict.get(key) != null
	
# TODO: max depth
func generate_path(start: Vector3, end: Vector3) -> Array[Vector3]:
	start = snap(start)
	end = snap(end)
	
	open_list = [SearchNode.new(0, end.distance_to(start), start, null)]
	closed_list = {}
	
	var node
	var depth = 0
	while open_list.size() > 0:
		
		depth += 1
		if (depth > MAX_DEPTH):
			print("Path not found!")
			return []
		
		# Get best node and add to closed list
		open_list.sort_custom(func (a,b): return a.f < b.f)
		node = open_list.pop_front()
		closed_list[node.position] = node
		
		if end.is_equal_approx(node.position):
			break
		
		var s = node.position
		var directions = [ 
			Vector3(s.x, s.y, s.z + 1.0),
			Vector3(s.x, s.y, s.z - 1.0),
			Vector3(s.x + 1.0, s.y, s.z),
			Vector3(s.x - 1.0, s.y, s.z)
		]
		
		for direction in directions:

			if closed_list.has(direction) or obstacle_dict.has(direction):
				continue

			var new_node = SearchNode.new(1, end.distance_to(direction), direction, node)
			
			var index = open_list.find(direction) 
			if index != -1:
				if open_list[index].g < new_node.g:
					continue
					
			open_list.append(new_node)
			
	var path : Array[Vector3] = []
	while node != null:
		path.append(node.position)
		node = node.parent
	path.reverse()
		
	return path
		
	

class SearchNode:
	var g: float
	var h: float
	var f: float
	var position: Vector3
	var parent: SearchNode
	func _init(g: float, h: float, position: Vector3, parent: SearchNode):
		self.g = g
		self.h = h
		self.f = g + h
		self.position = position
		self.parent = parent
