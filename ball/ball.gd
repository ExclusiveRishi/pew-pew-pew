extends RigidBody2D

@export var speed = 3000
@export var color = Globals.CharacterColor.Green

@onready var skin: Sprite2D = $Sprite2D

func _ready() -> void:
	var color_path: String
	# apply the color
	match color:
		Globals.CharacterColor.Green:
			color_path = "res://Assets/Balls/green_body_circle.png"
		Globals.CharacterColor.Red:
			color_path = "res://Assets/Balls/red_body_circle.png"
		Globals.CharacterColor.Pink:
			color_path = "res://Assets/Balls/pink_body_circle.png"
		Globals.CharacterColor.Yellow:
			color_path = "res://Assets/Balls/yellow_body_circle.png"
	skin.texture = load(color_path)

func _on_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		body.hit()
	queue_free()
