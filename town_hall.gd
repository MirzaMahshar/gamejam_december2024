extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.start($StartPosition.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_teleport_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player Entered")
		var root_node = get_tree().get_root()
		var scene_node = root_node.get_node("TownHall")
		scene_node.queue_free()
		
		var target_scene = load("res://scene/water_temple.tscn")
		var target_node = target_scene.instantiate()
		root_node.add_child(target_node)
