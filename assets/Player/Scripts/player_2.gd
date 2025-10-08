extends CharacterBody2D

@export var speed: float = 500
@export var laser_scene: PackedScene
@export var shoot_cooldown: float = 0.25
@export var laser_sound: AudioStream

@export var w: String = "p2_up"
@export var s: String = "p2_down"
@export var a: String = "p2_left"
@export var d: String = "p2_right"
@export var shoot_action: String = "p2_shoot"

var can_shoot: bool = true

func _ready() -> void:
	position = Vector2(600, 500)

func _process(_delta: float) -> void:
	# Movement (WASD)
	var direction = Input.get_vector(a, d, w, s)
	velocity = direction * speed
	move_and_slide()

	# Shooting (custom shoot key)
	if Input.is_action_pressed(shoot_action) and can_shoot:
		_shoot_laser()

func _shoot_laser() -> void:
	can_shoot = false

	var laser = laser_scene.instantiate()
	get_parent().add_child(laser)
	laser.global_position = $Muzzle.global_position

	if laser_sound:
		var player = AudioStreamPlayer2D.new()
		player.stream = laser_sound
		player.position = position
		get_parent().add_child(player)
		player.play()
		player.connect("finished", Callable(player, "queue_free"))

	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
