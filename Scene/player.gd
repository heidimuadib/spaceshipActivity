extends CharacterBody2D
@export var speed =500
var screen_size: Vector2

func _ready() -> void:
	position=Vector2(100, 500)

func _process(_delta: float) -> void:
	var direction=Input.get_vector("left","right","up","down")
	
	velocity = direction * speed
	move_and_slide()
