extends "res://characters/character.gd"


var can_shoot : bool = true
var enemy_firedelay : float = 1.5
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	await get_tree().physics_frame
	update_path()
	$PathTimer.autostart = true
	
func _process(_delta: float) -> void:
	var player_pos = global_position.direction_to(Globals.player_position)
	look_target = player_pos
	look_at(Globals.player_position)
	shoot_direction = player_pos
	var next_path_pos := nav_agent.get_next_path_position()
	move_target = global_position.direction_to(next_path_pos)
	if can_shoot:
		shoot()
		$ShootTimer.start(enemy_firedelay)
		can_shoot = false
	velocity = move_target * speed
	move_and_slide()

func update_path() -> void:
	nav_agent.target_position = Globals.player_position

func shoot() -> void:
	var ball = ball_path.instantiate() as RigidBody2D
	# enable bullet's collsion for the player
	ball.set_collision_mask_value(3, true)
	ball.color = Globals.CharacterColor.Red
	$"../../Bullets".add_child(ball)
	ball.global_position = ShootPos.global_position
	ball.apply_impulse(shoot_direction * bullet_speed)

func _on_timer_timeout() -> void:
	can_shoot = true

func hit() -> void:
	queue_free()

func _on_path_timer_timeout() -> void:
	update_path()
