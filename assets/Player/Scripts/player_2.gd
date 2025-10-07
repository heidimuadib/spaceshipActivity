extends CharacterBody2D

@export var speed = 500
var screen_size: Vector2

@export var w: String = "p2_up"
@export var s: String = "p2_down"
@export var a: String = "p2_left"
@export var d: String = "p2_right"

func _ready() -> void:
	
	position=Vector2(100, 500)
	
func _process(_delta: float) -> void:

	var direction = Input.get_vector(a, d, w, s)
	velocity = direction * speed
	move_and_slide()
