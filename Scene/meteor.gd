extends Node2D

var fall_speed = 30

func _ready():
	var screen_size = get_viewport_rect().size
	randomize()
	

	for child in get_children():
		if str(child.name).begins_with("Sprockk"):
			child.position = Vector2(randi_range(0, screen_size.x), randf_range(-screen_size.y, 0))

func _process(delta):
	var screen_size = get_viewport_rect().size
	
	for child in get_children():
		
		if str(child.name).begins_with("Sprockk"):
			
			child.position.y += fall_speed * delta
			
			
			var num_str = str(child.name).lstrip("Sprockk") 
			var idx = int(num_str) if num_str.is_valid_int() else 1
			child.rotation += (0.1 + idx * 0.02) * delta
			
			
			if child.position.y > screen_size.y:
				child.position = Vector2(randi_range(0, screen_size.x), 0)
