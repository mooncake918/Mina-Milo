extends PanelContainer

@onready var main_menu: Panel = $MarginContainer/HBoxContainer/Menu
@onready var menu_parent: MarginContainer = $MarginContainer/HBoxContainer/Menu/MarginContainer
@onready var bucket_list: GridContainer = $MarginContainer/HBoxContainer/Menu/MarginContainer/bucketList

func _ready():
	self.visible = true
	main_menu.visible = true

func _set_menu(menu):
	var wasClosed = not menu.visible
	main_menu.visible = wasClosed
	menu.visible = wasClosed
