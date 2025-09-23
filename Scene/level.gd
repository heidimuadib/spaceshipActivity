extends Node2D

@export var meteor_scene: PackedScene = load("res://Scene/meteor.tscn")
@export var min_meteors: int = 5
@export var max_meteors: int = 6

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(_delta):
	# Keep the meteor count between min and max
	while $Meteors.get_child_count() < min_meteors:
		_spawn_meteor()
	if $Meteors.get_child_count() < max_meteors and rng.randi_range(0, 1) == 1:
		_spawn_meteor()

func _spawn_meteor():
	var meteor = meteor_scene.instantiate()

	# randomize spawn X
	var screen_width = get_viewport().get_visible_rect().size.x
	meteor.position = Vector2(rng.randf_range(0, screen_width), -50)

	$Meteors.add_child(meteor)
