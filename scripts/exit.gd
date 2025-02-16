extends Node2D

var players_touching := 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		players_touching += 1
		check_players()

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("players"):
		players_touching -= 1

func check_players() -> void:
	if players_touching >= 2:
		GameManager.next_level()
