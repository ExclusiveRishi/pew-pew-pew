extends Node

enum CharacterColor {Green, Red, Pink, Yellow}

var player_position : Vector2 = Vector2.ZERO
var player_bullet_speed : int = 3000
var player_health : int = 100

func reload_globals() -> void:
	player_position = Vector2.ZERO
	player_bullet_speed = 3000
	player_health = 100
