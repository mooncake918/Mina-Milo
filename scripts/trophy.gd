extends Area2D

@onready var win_label: Label = $Label

# Function triggered when a body enters the area
func _on_body_entered(body: Node2D) -> void:
	show_win_message()

# Function to show the "You Win!" message
func show_win_message():
	if win_label:
		win_label.visible = true  # Make the label visible when the player enters
		print("You Win! message shown")  # Optional debug message
