extends Node2D

@export var enemy_wave = 1
@export var enemies_to_spawn = 5
@export var enemy_speed = 500
@export var enemy_firedelay = 1.5
@export var enemy_bullet_speed = 1000
@export var spawn1 : Marker2D
@export var spawn2 : Marker2D
@export var spawn3 : Marker2D
@export var spawn4 : Marker2D
@export var enemies_node : Node2D
@onready var spawn_points = [spawn1, spawn2, spawn3, spawn4]

var enemy_path : PackedScene = preload("res://characters/enemy.tscn")
var is_wave_active = false

func _ready() -> void:
	start_new_wave(enemies_to_spawn)

func _process(_delta: float) -> void:
	if is_wave_active and enemies_node.get_child_count() == 0:
		is_wave_active = false
		print("Wave Complete! Starting next wave...")
		enemy_wave += 1
		start_new_wave(enemies_to_spawn + (enemy_wave * 2))

func start_new_wave(count : int) -> void:
	is_wave_active = true
	for i in range(count):
		var enemy = enemy_path.instantiate()
		var spawn_node = spawn_points.pick_random()
		enemy.enemy_firedelay = enemy_firedelay
		enemy.speed = enemy_speed
		enemies_node.add_child(enemy)
		var offset = Vector2(randf_range(-25, 25), randf_range(-25, 25))
		enemy.global_position = spawn_node.global_position + offset
		await get_tree().create_timer(0.1).timeout
	Globals.player_bullet_speed = enemy_bullet_speed + 500
	enemy_bullet_speed += 200
	enemies_to_spawn += 5
	enemy_speed += 100
	enemy_firedelay -= 0.05
