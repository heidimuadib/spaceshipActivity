extends Node2D

@export var min_meteors: int = 5
@export var max_meteors: int = 6

var rng := RandomNumberGenerator.new()
var meteor_paths := [
	"res://Scene/meteor/Scenes/Meteor1.tscn",
	"res://Scene/meteor/Scenes/Meteor2.tscn",
	"res://Scene/meteor/Scenes/Meteor3.tscn",
	"res://Scene/meteor/Scenes/Meteor4.tscn"
]


func _ready():
	rng.randomize()

func _process(_delta):
	
	while $Meteors.get_child_count() < min_meteors:
		_spawn_meteor()
	if $Meteors.get_child_count() < max_meteors and rng.randi_range(0, 1) == 1:
		_spawn_meteor()

func _spawn_meteor():
	var random_path = meteor_paths[rng.randi_range(0, meteor_paths.size() - 1)]
	var meteor_scene = load(random_path)
	var meteor = meteor_scene.instantiate()

	var screen_width = get_viewport().get_visible_rect().size.x
	meteor.position = Vector2(rng.randf_range(0, screen_width), -50)

	$Meteors.add_child(meteor)
