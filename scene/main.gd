extends Node

var score
	
func _ready():
	pass


func _on_main_menu_start_game() -> void:
	$MainMenu.hide()
	$Player.start($StartPosition.position)
