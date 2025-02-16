extends Camera2D

@export var player1: Node2D
@export var player2: Node2D

var min_zoom = Vector2(1, 1)
var max_zoom = Vector2(2, 2)
var max_distance = 400

func _process(_delta):
	if not player1 or not player2:
		return

	# Compute midpoint
	var midpoint = (player1.global_position + player2.global_position) / 2
	position = midpoint  # Move camera to midpoint

	# Compute zoom based on distance
	var distance = player1.global_position.distance_to(player2.global_position)
	var zoom_factor = clamp(distance / max_distance, 2, 3)
	
	zoom = lerp(min_zoom, max_zoom, zoom_factor)  # Smooth zooming
