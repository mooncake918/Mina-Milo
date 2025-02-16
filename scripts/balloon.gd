extends Area2D

var player_nearby: bool = false
@export var animation_name: String = "move"
@onready var animation: AnimationPlayer = $AnimationPlayer

var start_position: Vector2 = Vector2(85, -3)

func _ready():
	position = start_position  # Ensure balloon starts at correct position

func _on_body_entered(_body: Node2D) -> void:
	player_nearby = true
	animation.set_active(true)
	animation.play(animation_name)
	
func _on_body_exited(_body: Node2D) -> void:
	player_nearby = false
	animation.pause()
