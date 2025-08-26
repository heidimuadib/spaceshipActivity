extends Node2D

@export var speed = 500
var screen_size: Vector2

@export var w: String = "p2_up"
@export var s: String = "p2_down"
@export var a: String = "p2_left"
@export var d: String = "p2_right"

func _ready() -> void:
	
	position=Vector2(100, 500)
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:

	var direction = Input.get_vector(a, d, w, s)
	
	position += direction * speed * delta
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
