extends Node

# From main menu, load first scene
func _ready():
	var root_node = get_tree().get_root()
	var start_scene = load("res://scene/town_hall.tscn")
	var start_node = start_scene.instantiate()
	root_node.add_child(start_node)
	

#func _on_main_menu_start_game() -> void:
	#$MainMenu.hide()
	#$Player.start($StartPosition.position)
	#get_tree().change_scene_to_file("res://scene/water_temple.tscn")
