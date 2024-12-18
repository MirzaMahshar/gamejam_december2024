extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.start($StartPosition.position)
	for npc in get_tree().get_nodes_in_group("NPC"):
		npc.interact_button_pressed.connect(_on_interactive_object_interact_button_pressed)
		npc.interact_area_reached.connect(_on_interactive_object_interact_area_reached)
	for object in get_tree().get_nodes_in_group("InteractiveObject"):
		object.interact_button_pressed.connect(_on_interactive_object_interact_button_pressed)
		object.interact_area_reached.connect(_on_interactive_object_interact_area_reached)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if InputMap.has_action("debug_key") and Input.is_action_just_pressed("debug_key"):
		signal_to_main()

signal packed_signal
func _on_teleport_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player Entered")
		packed_signal.emit("change_level", ["TownHall", "res://scene/water_temple.tscn"])

# Signal handler to main
signal debug_signal
func signal_to_main():
	debug_signal.emit()

func _on_interactive_object_interact_button_pressed(args) -> void:
	packed_signal.emit("interact_object", args)

func _on_interactive_object_interact_area_reached(args) -> void:
	$Player.interact_popup(args)
