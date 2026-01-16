extends "res://characters/character.gd"

func _ready() -> void:
	bullet_speed = Globals.player_bullet_speed
	$"../HUD".update_health()

func _process(delta: float) -> void:
	move_target = Input.get_vector("left", "right", "up", "down")
	look_target = get_global_mouse_position()
	shoot_direction = (get_global_mouse_position() - global_position).normalized()
	bullet_speed = Globals.player_bullet_speed
	if (Input.is_action_just_pressed("shoot")):
		shoot()
	super(delta)

func shoot() -> void:
	var ball = ball_path.instantiate() as RigidBody2D
	# enable bullet's collsion for the enemy (enemy is on the layer 4)
	ball.set_collision_mask_value(4, true)
	$"../Bullets".add_child(ball)
	ball.global_position = ShootPos.global_position
	ball.apply_impulse(shoot_direction * bullet_speed)

func hit() -> void:
	Globals.player_health -= 10
	$"../HUD".update_health()
	if Globals.player_health <= 0:
		Globals.reload_globals()
		get_tree().change_scene_to_file("res://end.tscn")

func _physics_process(_delta: float) -> void:
	Globals.player_position = global_position
