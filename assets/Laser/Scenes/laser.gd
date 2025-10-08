extends Area2D

@export var speed: float = 900
@export var damage: int = 20

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Move straight upward (by default)
	velocity = Vector2(0, -speed)
	
	# Play sound if available
	if has_node("AudioStreamPlayer2D"):
		$AudioStreamPlayer2D.play()

func _process(delta: float) -> void:
	position += velocity * delta

	# Remove laser if it leaves the screen
	if position.y < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
