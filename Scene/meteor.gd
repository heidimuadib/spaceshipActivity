extends Node2D

var velocity: Vector2 = Vector2.ZERO
var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var direction = Vector2(rng.randf_range(-0.5, 0.5), 1).normalized()
	var speed = rng.randf_range(150, 600)
	velocity = direction * speed

func _process(delta):
	position += velocity * delta

	var height = get_viewport().get_visible_rect().size.y
	if position.y > height + 50:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
