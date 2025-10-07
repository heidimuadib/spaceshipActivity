extends Area2D

@export var min_speed: float = 200
@export var max_speed: float = 500
@export var rotation_min: float = 40
@export var rotation_max: float = 100
@export var min_scale: float = 0.5
@export var max_scale: float = 1.0
@export var max_drift: float = 80  # horizontal drift range (slight slant)

var velocity: Vector2
var rotation_speed: float
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

	# 🎨 Randomly select meteor texture (1.png → 4.png)
	var meteor_id = rng.randi_range(1, 4)
	var path := "res://assets/meteor/Sprites/%d.png" % meteor_id

	if ResourceLoader.exists(path):
		$Sprite2D.texture = load(path)
	else:
		push_warning("⚠️ Texture not found at: %s" % path)

	# 🌀 Randomize speed, rotation, and size
	var speed := rng.randf_range(min_speed, max_speed)
	rotation_speed = rng.randf_range(rotation_min, rotation_max)
	var scale_factor := rng.randf_range(min_scale, max_scale)
	scale = Vector2(scale_factor, scale_factor)

	# 📍 Random spawn position (top)
	var screen_size := get_viewport().get_visible_rect().size
	position = Vector2(rng.randf_range(0, screen_size.x), rng.randf_range(-150, -50))

	# ⬇️ Slight diagonal fall (adds realism)
	var drift_x := rng.randf_range(-max_drift, max_drift)
	velocity = Vector2(drift_x, speed)

	# 🌀 Make rotation follow drift direction for realism
	rotation_speed *= sign(drift_x)

func _process(delta: float) -> void:
	# 💫 Move and rotate sprite (not the whole body)
	position += velocity * delta
	$Sprite2D.rotation_degrees += rotation_speed * delta

	# ❌ Remove if off-screen
	if position.y > get_viewport().get_visible_rect().size.y + 100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(10)
	queue_free()
