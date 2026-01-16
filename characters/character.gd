extends CharacterBody2D

@onready var ball_path: PackedScene = preload("res://ball/ball.tscn")
@onready var ShootPos: Marker2D = $end_of_gun


@export var speed = 300.0
var look_target : Vector2 = Vector2.ZERO
var move_target : Vector2 = Vector2.ZERO
var shoot_direction : Vector2 = Vector2.ZERO
@export var bullet_speed : int = 1000


func _process(_delta: float) -> void:
	look_at(look_target)
	velocity = move_target * speed
	move_and_slide()

func hit() -> void:
	print("Character was hit")
