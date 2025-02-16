extends Node

var score = 0
var current_level = 1
var level_path = "res://scenes/levels/"

func add_point():
	score += 1

func next_level():
	current_level += 1
	score = 0
	var full_path = level_path + "level" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("Player entered next level")
