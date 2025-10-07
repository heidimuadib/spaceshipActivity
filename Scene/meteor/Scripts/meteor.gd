extends Area2D

@export var min_speed: float = 200
@export var max_speed: float = 500
@export var rotation_min: float = 40
@export var rotation_max: float = 100

var velocity: Vector2 = Vector2.ZERO
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

	# 🎨 Randomly pick 1 of 4 meteor shapes (Meteor1.tscn ... Meteor4.tscn)
	var meteor_id = rng.randi_range(1, 4)
	var path: String = "res://Scene/meteor/Scenes/Meteor" + str(meteor_id) + ".png"
	
	if ResourceLoader.exists(path):
		$Sprite2D.texture = load(path)
	else:
		push_warning("Texture not found at: " + path)

	# 🌀 Random rotation speed and fall speed
	var speed = rng.randf_range(min_speed, max_speed)
	var rotation_speed = rng.randf_range(rotation_min, rotation_max)

	# 📍 Random spawn position (top of screen)
	var screen_size = get_viewport().get_visible_rect().size
	var random_x = rng.randf_range(0, screen_size.x)
	var random_y = rng.randf_range(-150, -50)
	position = Vector2(random_x, random_y)

	# ⬇️ Straight down movement
	velocity = Vector2(0, speed)

	# 💫 Animate rotation each frame
	set_process(true)
	set_meta("rotation_speed", rotation_speed)

func _process(delta: float) -> void:
	position += velocity * delta
	rotation_degrees += get_meta("rotation_speed") * delta

	# ❌ Remove meteor when offscreen bottom
	var height = get_viewport().get_visible_rect().size.y
	if position.y > height + 100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(10)
	queue_free()
