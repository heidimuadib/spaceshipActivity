extends Node2D

var speed := 200 

func _ready():
	var screen_size = get_viewport_rect().size
	
	position = Vector2(screen_size.x / 2, screen_size.y - 50) 

func _process(delta):
	var velocity = Vector2.ZERO

	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed * delta
		position += velocity
