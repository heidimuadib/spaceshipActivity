extends CharacterBody2D

@export var speed: float = 500
@export var laser_scene: PackedScene
@export var shoot_cooldown: float = 0.25
@export var laser_sound: AudioStream

var can_shoot: bool = true

func _ready() -> void:
	position = Vector2(200, 500)

func _process(_delta: float) -> void:
	# 🎮 Player movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	# 🔫 Shooting (spacebar)
	if Input.is_action_pressed("shoot") and can_shoot:
		_shoot_laser()

func _shoot_laser() -> void:
	can_shoot = false

	# 🎯 Spawn laser from muzzle
	if not laser_scene:
		push_warning("⚠️ No laser scene assigned!")
		return
	
	if not has_node("Muzzle"):
		push_warning("⚠️ No 'Muzzle' node found under player!")
		return

	var laser = laser_scene.instantiate()
	get_parent().add_child(laser)
	laser.global_position = $Muzzle.global_position

	# 🔊 Play laser sound
	if laser_sound:
		var player_sound = AudioStreamPlayer2D.new()
		player_sound.stream = laser_sound
		player_sound.global_position = $Muzzle.global_position
		get_parent().add_child(player_sound)
		player_sound.play()
		player_sound.connect("finished", Callable(player_sound, "queue_free"))

	# ⏳ Cooldown delay before next shot
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
